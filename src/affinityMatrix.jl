"""
Computes the affinity matrix for a given distance matrix

# Args:
* diff: Distance matrix
*   K: Number of nearest neighbours to sparsify similarity
*   alpha: Variance for local model

# Returns:
   Affinity matrix using exponential similarity kernel scaled by k nearest
   neighbour average similarity
"""
function affinityMatrix(diff,K=20,alpha=0.5)
    N = size(diff)[1]
    assert(K < N)

    diff = (diff + diff') ./ 2
    set_diag!(diff) # Zeroize the diagnal

    # For each row, sort the values in this row
    sortedColumns = hcat([sort(diff[i,:]) for i in 1:N]...)'

    # Mean of K nearest distances of each row
    means = [finiteMean(sortedColumns[i,2:K+1]) for i in 1:N] .+ EPS;

    # Outer product
    Sig = [mean((means[i], means[j]))
        for j=1:length(means), i=1:length(means)] ./3*2 .+ diff/3 .+ EPS
    Sig[Sig .<= EPS] .= EPS
    densities = reshape([pdf(Normal(0, (Sig.*alpha)[i,j]), diff[i,j])
        for j in 1:N for i in 1:N], N, N)

    W = (densities .+ densities') ./ 2
end
