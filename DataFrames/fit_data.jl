# DataFrames, Vectors, Linear Models for Data Fitting.
using DataFrames, GLM, StatsBase

################################################################################
function parse_file(fname)
       # Read the whole file and return a collection of lines.
       lines = readlines(fname)

       # Create two empty 1D arrays (vectors).
       xs = Float64[]
       ys = Float64[]

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
       return df
end

################################################################################
function main()
    df = parse_file("poly_data.dat")

    # Create a linear model to fit the following equation to the data. Note that
    # the variables "y" and "X" correspond to the column names of the DataFrame.
    mdl = lm(@formula(y ~ X + X^2 + X^3), df);
    # Show all the details of the resulting model.
    @show mdl
    println("----------------------------------")
    # Print just the coefficients of the fit, with 5 digits of accuracy.
    println(round.(coef(mdl); digits=5))
    println("----------------------------------")

end

main()
