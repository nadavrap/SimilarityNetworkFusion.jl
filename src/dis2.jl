"""
Build a distance matrix from data/features matrix.
Compute the euclidean distance of every two rows, and returns it as a distance
matrix.
# Args:
* X - A matrix
# Returns:
A squared simetric matrix of size size(X)[1].
"""
function dist2(X)
    n = size(X)[1]
    sumsqX = sum(X.^2, 2) # Rows sums

    XX = 2 * (X * X')
    # Repeat rows + repeat columns
    res = repeat(sumsqX, outer=[1,n]) +
            repeat(sumsqX, outer=[1,n])' - XX
    res[res .< 0] = 0
    res
end
