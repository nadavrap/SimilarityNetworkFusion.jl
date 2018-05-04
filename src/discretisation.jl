"""
Discretise eigen vectors matrix.
"""
function discretisation(eigenVectors)
  eigenVectors = sapply_df(DataFrame(eigenVectors'),normalize_sqrt)'

  n = size(eigenVectors)[1]
  k = size(eigenVectors)[2]

  R = zeros(k,k)
  R[:,1] = eigenVectors[Integer(round(n/2)),:]'

  c = zeros(n)
  for j in 2:k
    c = c + abs.(eigenVectors * R[:,j-1])
    i = indmin(c)
    R[:,j] = eigenVectors[i,:]'
  end

  lastObjectiveValue = 0
  eigenDiscrete = discretisationEigenVectorData(eigenVectors * R)
  for i in 1:20
    eigenDiscrete = discretisationEigenVectorData(eigenVectors * R)

    U, S, V = svd(eigenDiscrete' * eigenVectors)

    NcutValue = 2 * (n-sum(S))
    if abs(NcutValue - lastObjectiveValue) < EPS
      break
    end
    lastObjectiveValue = NcutValue
    R = V * U'
  end

  return (eigenDiscrete,eigenVectors)
end

"""
Discretise matrix, so the maximal position is 1, and the others are 0.
# Args:
* eigenVector - A matrix.
# Returns:
A discrete matrix where for each row, all elements are zeros except one element
   with the value 1.
"""
function discretisationEigenVectorData(eigenVector)
  Y = zeros(size(eigenVector))
  j = max_inds(eigenVector,1)
  for i in 1:(size(eigenVector)[1])
      Y[i,j[i]]=1
  end
  return Y
end
