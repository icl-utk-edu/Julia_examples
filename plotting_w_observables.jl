# Comprehension, Observables, Interactive Plotting.
using GLMakie

points = [Point2f(x, x*x) for x in 1:10]
# Creating an "Observable" will allow Makie to react to its changes.
points_O = Observable(points)
# Pass the Observable to Makie, not the raw points.
fig,ax,p = scatter(points_O)
# Show the plot in a new window.
display(fig)

# Block for user input.
n=readline()
# Necessary for progress.
print("")

# Add a point to the Observable and it will be automatically added to the plot.
# The notation points_O[] is _not_ array indexing. It accesses the raw data structure
# that is inside the observable. In this case, the vector "points".
push!(points_O[], Point2f(12,12*12))

# Alternativelly, we could push the new datapoint directly into the raw vector.
#push!(points, Point2f(12,12*12))

notify(points_O)

# Wait until the window is destroyed.
wait(display(fig))

