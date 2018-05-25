using Base.Test
#using SimilarityNetworkFusion

include("../src/Others.jl")

print("Testing others helper functions...")
# Test finiteMean
@test finiteMean([1,2]) == 1.5
@test finiteMean([1,2, Inf]) == 1.5
@test finiteMean([1,2, -Inf]) == 1.5
@test finiteMean([Inf, 1,2, -Inf]) == 1.5


# Test set_diag!
X = reshape([0,1,1,1,0,0,0,0,1], 3,3)
X1 = reshape([0,1,1,1,0,0,0,0,1], 3,3)
X2 = reshape([0.,1,1,1,0,0,0,0,1], 3,3)
# Test mismatch types error
@test_throws ErrorException set_diag!(X1, .5)
@test set_diag!(X2, .5) == nothing

@test set_diag!(X, 0) == nothing
@test diag(X) == [0,0,0]
@test diag(X2) == [.5,.5,.5]
@test X2 == reshape([0.5,1,1,1,0.5,0,0,0,.5], 3,3)


@test allequal((1,1)) == true
@test allequal((1,0)) == false
@test allequal((1.3,0)) == false
@test allequal(('a', 'a', 'a')) == true
true
