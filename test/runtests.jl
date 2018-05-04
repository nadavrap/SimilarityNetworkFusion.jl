#!julia
using SNFtool
using Base.Test

tests = ["testSNF",
         "testOthers"]

tic()
println("Runing tests:")
for t in tests
         fp = "$(t).jl"
         println("* $fp ...")
         @time @test include(fp)
@time @test include("testSNF.jl")
@time @test include("testOthers.jl")
toc()
