"""
Normalization method for affinity matrices.
Refer to equation (2) in the Methods section of the paper.
Each row is normalized such that the diagonal is the constant 0.5, and the sum
of all other elements in the row is also 0.5.
This results in a matrix where the sum of rows is 1, and 0.5 is on the
diagonal.
# Args:
* X - An affinity matrix.
# Returns:
A normalized matrix.
"""
function aff_normalize(X)
    row_sum_mdiag = mapslices(sum,X,2) .- diag(X)
    #If rowSumx(X) == diag(X), set row.sum.mdiag to 1 to avoid div by zero
    row_sum_mdiag[row_sum_mdiag .== 0] = 1
    X = X./(2.*row_sum_mdiag)
    set_diag!(X, 0.5)
    X
end
