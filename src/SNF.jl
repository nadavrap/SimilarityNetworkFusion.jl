include("aff_normalize.jl")
include("dominateset.jl")
"""
Similarity Network Fusion takes multiple views of a network (Wall) and
fuses them together to create a overall affinity matrix.
### Args:
 * Wall: List of matrices, each element is a square symmetric affinity matrix.
 * K: Number of neighbors used in the K-nearest neighbours step
 * t: Number of iterations for the diffusion process
### Returns:
Unified similarity graph of all data types in Wall.
"""
function SNF(Wall, K=20, t=20)
    #Check if Wall dimensions are consistant across all matrices in Wall
    if !allequal([size(x) for x  in Wall])
        warn("Dimensions of affinity matrices do not match.")
    end

    LW = length(Wall)

    #Normalize different networks to avoid scale problems.
    Ps = deepcopy(Wall)
    for i in 1:LW
      Wall[i] = aff_normalize(Wall[i])
      Wall[i] = (Wall[i] + Wall[i]')./2
    end

    ### Calculate the local transition matrix. (KNN step)
    Ss = [dominateset(Wall[i], K) for i in 1:LW]

    #Perform the diffusion for t iterations
    # Corresponde to equation (7) in the Methods section
    for i in 1:t
        for j in 1:LW
            sumWJ = zeros(size(Wall[j]))
            for k in 1:LW
                if k != j
                    sumWJ = sumWJ .+ Wall[k]
                end
            end
            Ps[j] = Ss[j] * (sumWJ./(LW-1)) * (Ss[j]')
        end

        #Normalize each new obtained networks.
        for j in 1:LW
          Wall[j] = aff_normalize(Ps[j])
          Wall[j] = (Wall[j] + Wall[j]')./2;
        end
    end

    # Construct the combined affinity matrix by summing diffused matrices
    W = sum(Wall)
    W = W./LW
    W = aff_normalize(W)
    W = (W + W') ./ 2
end
