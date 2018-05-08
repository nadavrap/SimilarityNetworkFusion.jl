using BinDeps
using Compat

@BinDeps.setup

libsnftool = library_dependency("snftool")

# package managers
provides(CSV, "snftool", libsnftool)
provides(CSV, "DataFrames", libsnftool)
provides(CSV, "Distributions", libsnftool)
provides(CSV, "Gadfly", libsnftool)
provides(CSV, "Cairo", libsnftool)

@BinDeps.install Dict(:libsnftool => :libsnftool)
