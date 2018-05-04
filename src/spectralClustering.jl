include("discretisation.jl")
"""
# Implements spectral clustering on given affinity matrix into K clusters.
#
# Args:
#   affinity: Affinity matrix (size NxN) to perform clustering on
#   K: Number of clusters
#   ctype (default 3): Used to speciy the type of spectral clustering
#
# Returns:
#   labels: A vector of length N assigning a label 1:K to each sample
"""
function spectralClustering(affinity, K, ctype=3)
    d = mapslices(sum, affinity, 2)
    # d is has second dimension of length 1, so remove it:
    d = vec(d)
    d[d .== 0] = EPS
    D = Diagonal(d)
    L = D - affinity
    if ctype == 1
        NL = L
    elseif ctype == 2
        Di = Diagonal(1./d)
        NL = Di * L
    elseif (ctype == 3)
        Di = Diagonal(1./sqrt.(d))
        NL = Di * L * Di
    end
    eg = eigfact(NL)
    res = sortperm(abs.(eg[:values]))
    U = eg[:vectors][:,res[1:K]]
    if ctype == 3
        U = sapply_df(DataFrame(U'), normalize_sqrt)'
    end
    eigDiscrete, continuous = discretisation(U)
    labels = max_inds(eigDiscrete, 1)
    return vec(labels)
end
