# Function Broadcasting, Inset Axis, Interactive Plotting, Event Listeners.
using GLMakie

WWIDTH = 1200
WHEIGHT = 800

fig, ax, p = scatter(Point2f.([0,1,2,3,4,5],[0,1,4,9,16,25]), markersize=50, color=:black)
# The "." in "Point2f.([0,1,2,3,4,5],[0,1,4,9,16,25])" means that the function Point2f()
# will be called once for each element of the collection. So this is equivalent to making
# all the calls:
# Point2f.(0,0)
# Point2f.(1,1)
# Point2f.(2,4)
# ...
# This behavior is called function broadcasting. The notation "f.(args)" is equivalent to
# the more explicit "broadcast(f, args)".

resize!(fig.scene, (WWIDTH, WHEIGHT))

# Remove the ticks and labels from the axes and make them look like a simple rectangle.
hidedecorations!(ax)

# Let's register a callback for a mouse-click event.
on(events(ax.scene).mousebutton, priority = 2) do event
    if event.button == Mouse.left && event.action == Mouse.press
        if Keyboard.g in events(fig).keyboardstate
            # If the left button was pressed _and_ the key "g" was held down.
            global inset_ax = Axis(fig[1, 1],
                                   xtickalign=1.0,
                                   ytickalign=1.0,
                                   xticklabelspace=0.0,
                                   yticklabelspace=0.0,
                                   tellwidth=false,
                                   tellheight=false,
                                   width=Relative(0.5),
                                   height=Relative(0.5),
                                   halign=0.9,
                                   valign=0.9,
                                   backgroundcolor=RGBAf(0.9,0.9,0.9,0.85))
            # Move up (Z direction) the new axis and its background).
            translate!(inset_ax.scene, 0, 0, 10)
            translate!(inset_ax.elements[:background], 0, 0, 9)

            # Plot a graph in the new axis.
            scatter!(inset_ax, Point2f.(0:10, 0:10), color=:red)

            # Consume the event.
            return Consume(true)
        end
    end
    return Consume(false)
end

# Wait until the window is destroyed.
wait(display(fig))


