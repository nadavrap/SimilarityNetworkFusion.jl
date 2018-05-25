using BinDeps
using Compat

@BinDeps.setup

#libsnftool = library_dependency("SimilarityNetworkFusion")

# package managers
try
    @BinDeps.install Dict(:CSV => :CSV)
end
# provides(CSV, "snftool", libsnftool)
# provides(CSV, "DataFrames", libsnftool)
# provides(CSV, "Distributions", libsnftool)
# provides(CSV, "Gadfly", libsnftool)
# provides(CSV, "Cairo", libsnftool)

@BinDeps.install Dict(:libsnftool => :libsnftool)
