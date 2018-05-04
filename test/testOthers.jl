using Base.Test
using SNFtool

print("Testing others helper functions...")
# Test finiteMean
tests_res1 = [
@test finiteMean([1,2]) == 1.5
@test finiteMean([1,2, Inf]) == 1.5
@test finiteMean([1,2, -Inf]) == 1.5
@test finiteMean((Inf, 1,2, -Inf)) == 1.5


# Test set_diag!
X = reshape([0,1,1,1,0,0,0,0,1], 3,3)
X1 = reshape([0,1,1,1,0,0,0,0,1], 3,3)
set_diag!(X1, val=.5)

@test set_diag!(X, val=0) == nothing
@test diag(X1) == [0.5,0.5,0.5]
@test X1 == reshape([0.5,1,1,1,0.5,0,0,0,.5], 3,3)


@test allequal((1,1)) == true
@test allequal((1,0)) == false
@test allequal((1.3,0)) == false
@test allequal(('a', 'a', 'a')) == true
