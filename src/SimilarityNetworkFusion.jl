module SimilarityNetworkFusion
    # Imports
    using CSV, DataFrames, Distributions
    using Gadfly, Cairo

    import Base: getindex
    # package code goes here
    EPS = eps(Float64)

    # Exports
    export
    affinityMatrix,
    dataset,
    displayClusters,
    dist2,
    finiteMean,
    dataset,
    sapply_df,
    spectralClustering,
    standardize,
    SNF

    # source files
    include("affinityMatrix.jl")
    include("dataset.jl")
    include("displayClusters.jl")
    include("dist2.jl")
    include("spectralClustering.jl")
    include("Others.jl")
    include("SNF.jl")

end # module
