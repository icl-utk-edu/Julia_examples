# DataFrames, Vectors
using  DataFrames

################################################################################
function parse_file(fname)
       # Read the whole file and return a collection of lines.
       lines = readlines(fname)

       # Create two empty 1D arrays (vectors).
       xs = Float64[]
       ys = Float64[]
        # Alternatively, explicitly calling the array constructor is equivalent.
#       xs = Array{Float64,1}()
#       ys = Array{Float64,1}()
        # Vector{T} is an alias for Array{T,1}
#       xs = Vector{Float64}()
#       ys = Vector{Float64}()

       # Process one input line at a time.
       for ln in lines
           # Tokenize the elements of each line on empty spaces.
           elems = split(ln)
           if "#" != elems[1]
               # For non-comments, parse the two elements as floats and add them to the vectors.
               x = parse(Float64, elems[1])
               push!(xs,x)
               y = parse(Float64, elems[2])
               push!(ys,y)
           end
       end
       # Create a DataFrame from the vectors.
       df = DataFrame(X = xs, y = ys)
       # All following alternatives are equivalent.
#       df = DataFrame(:X => xs, :y => ys)
#       df = DataFrame("X" => xs, "y" => ys)
#       df = DataFrame([:X => xs, :y => ys])

       return df
end

################################################################################
function main()
    df = parse_file("poly_data.dat")
    @show df
end

main()

