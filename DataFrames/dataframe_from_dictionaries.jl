# DataFrames, Dictionaries
using DataFrames

################################################################################
function parse_it(fname)
       # Read the whole file and return a collection of lines.
       lines = readlines(fname)

       # Create an empty DataFrame
       df = DataFrame(X=Float64[], y=Float64[])

       # Process one input line at a time.
       for ln in lines
     
           # Split the elements of the line on empty spaces.
           elems = split(ln)
           if "#" != elems[1]
               # Create an empty dictionary.
               tmp_dict = Dict()

               # Parse the two elements as floats and put them in the dictionary.
               tmp_dict[:X] = parse(Float64, elems[1])
               tmp_dict[:y] = parse(Float64, elems[2])

               # Append the dictionary to the DataFrame. Note that appending one row at
               # a time is an inefficient way to create a DataFrame. Instead create the
               # whole thing in one go from vectors of data.
               append!(df, tmp_dict)
           end
       end

       return df
end

################################################################################
function main()
    df = parse_it("poly_data.dat")
    @show df
end

main()

