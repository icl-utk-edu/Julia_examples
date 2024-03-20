# Vectors, Observables, Makie, Animation, Colors & Colormaps.
using GLMakie

function kill_some(population, death_threshold)
  next_pop = population
  # For every individual in the population
  for m in 1:population
      p = rand()
      # If it had bad luck, remove it from the count of living.
      if( p < death_threshold )
          next_pop -= 1
      end
  end
  return next_pop
end


function moth_simulator()
  # Start with a random (large) number of peppered moths
  # and a random (small) number of dark moths.
  pepp = rand(1000:1500)
  dark = rand(20:30)
  total = pepp+dark
  
  # Create a vectors that contains the current populations of peppered moths for time-step 0.
  points_pepp = [Point2f(0,pepp)]
  # Same for dark moths.
  points_dark = [Point2f(0,dark)]
  # Create a vector that we will use later to index into the colormap.
  clrs = [i for i in 1:80]
  # Create Observables from the vectors.
  points_pepp_O = Observable(points_pepp)
  points_dark_O = Observable(points_dark)
  clrs_0 = Observable(clrs)

  # Plot the peppered population Observable using 80 colors from the :OrRd colormap (https://docs.makie.org/stable/explanations/colors/).
  # Each point gets a different color by using the "color" vector to index into the colormap.
  fig,ax,p = scatter(points_pepp_O, color=clrs_0, colormap=:OrRd, colorrange=(1,80))
  # Set limits for the Y axis, but let the X axis have an auto-limit.
  limits!(ax, nothing, nothing, 0, total+10)
  # Plot the dark population Observable using 80 colors from the :Greys colormap (https://docs.makie.org/stable/explanations/colors/)
  # Each point gets a different color by using the "color" vector to index into the colormap.
  p2 = scatter!(points_dark_O, color=clrs_0, colormap=:Greys, colorrange=(1,80))
  
  display(fig)
  
  # For 1200 time-steps apply a simplified survival of the fittest model.
  for ts in 1:1200
    # Kill some peppered moths with 10.5% probability of death.
    pepp = kill_some(pepp, 10.5/100)
    # Kill some dark moths with 10.0% probability of death.
    dark = kill_some(dark, 10.0/100)
  
    # Scale up the populations to the original total number.
    f = total/(pepp+dark)
    pepp *= f
    dark *= f
  
    # Add a point to each vector for the current time-step & population.
    push!(points_pepp_O[], Point2f(ts, pepp))
    push!(points_dark_O[], Point2f(ts, dark))
  
    # If we have more than 80 points in the vector, drop the first one, so we
    # only plot the last 80.
    if( ts > 80 )
        popfirst!(points_pepp_O[])
        popfirst!(points_dark_O[])
    end
    # Notify the Observables and update the graph.
    notify(points_pepp_O)
    notify(points_dark_O)
    display(fig)
    # Add a small delay to make the animation more reasonable.
    sleep(0.02)
  end

  # Wait until the window is destroyed.
  wait(display(fig))
end

moth_simulator()
