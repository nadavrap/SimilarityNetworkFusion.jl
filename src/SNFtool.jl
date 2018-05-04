module SNFtool
    # Imports
    using CSV, DataFrames, Distributions
    using Gadfly, Cairo

    # package code goes here
    EPS = eps(Float64)

    # Exports
    finiteMean

    include("Others.jl")
end # module
