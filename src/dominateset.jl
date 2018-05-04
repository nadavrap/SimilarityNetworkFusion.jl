"""
This function outputs the top KK neighbors.
    For each row in the matrix xx, zeroize the diagonal element, and all
    elements not in the KK neares nodes (columns with larges values).
    In the Methods section of the paper, this refers to generating the S matrix
    from P.
    # Args:
    * xx - Affinity matrix
    * KK - number of neighbors
"""
function dominateset(xx,KK=20)
    function zero_top(x)
        # Zeroize the lowest values in the vector x,
        # leaving the top KK untacted
        s = sortperm(x)
        x[s[1:(length(x)-KK)]] = 0
        x
    end

    S = zeros(size(xx))
    for i in 1:(size(xx)[1])
        S[i,:] = zero_top(xx[i,:])
    end
    row_normalize(S)
end
