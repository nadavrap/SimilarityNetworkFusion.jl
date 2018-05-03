#!julia
using SNFtool
using Base.Test

# write your own tests here
@test 1 == 1

tic()
println("Test SNF functionallity")
@time @test include("testSNF.jl")
println("Test other functions")
@time @test include("testOthers.jl.jl")
toc()
