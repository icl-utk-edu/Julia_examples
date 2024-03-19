# Comprehension, Observables, Plotting Animation, Exporing Video.
using GLMakie

points = [Point2f(x, x*x) for x in 1:10]
points_O = Observable(points)
fig,ax,p = scatter(points_O)

record(fig, "simple_anim.mp4", 1:90; framerate=30) do t
    idx = 1+t%10
    points_O[][idx] = Point2f(idx,(idx*idx)+t)
    notify(points_O)
    # Automatically reset the axis as the data changes.
    autolimits!(ax)
end
