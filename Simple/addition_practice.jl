# Loops, Types, Timestamps, and Asynchronous Execution (tasks).
using Dates

prcnt::Float32 = 100
points::Int = 0
UB::Int = 30

for i in 1:UB
    term = false
    a = rand(2:9)
    b = rand(2:9)

    print("[",i,"] ",a,"+",b," = ")
    t0 = now()

    x = -1

    # Create a Task and schedule it to run on any
    # available thread in the specified threadpool
    Threads.@spawn x = tryparse(Int32, readline())
    
    # A different way to achieve asynchronous execusion
    # is by using the macro "@async" whose function is to:
    # "Wrap an expression in a Task and add it to the
    #  local machine's scheduler queue."
    # However, @async has task migration side-effects, so
    # Threads.@spawn is the prefered way.
#    @async x = tryparse(Int32, readline())
    while (x < 0)
        # The following call does not print anything, but is
        # necessary for progress (I/O flushing?).
        print("")
        dt = Dates.value(now()-t0)/1000
        if dt > 4
            println("\nLate response.")
            exit()
        end
    end

    if a+b == x
        println("Correct!")
    else
        println("Wrong answer. Correct answer is: ",a+b)
        exit()
    end
end
