"""
Normalize a vector
### Parameters:
* v - A vector
### Returns
 A normalize vector, where each component is divided by the sum of elements of
 the vector v.
"""
vec_norm(v) = v ./ sum(v)

"""
Normalize rows in a matrix.
Given a matrix, normalize each row seperately by dividing each element by the
sum of elements in the row.
"""
row_normalize(X) = mapslices(vec_norm,X,2)

"""
Test whether all the elements in the vector are the same
### Parameters:
* x - a vector.
### Retruns:
A boolean value.
"""
allequal(x) = all(y->y==x[1],x)

"""
Normalize a vector by dividing each element by the square root of the sum of the
squared of elements.
### Parameters:
* x - a vector.
### Returns:
A normalized vector.
"""
normalize_sqrt(x) = x ./ sqrt(sum(x.^2))

"""
Mean of elements ignoring infinit (and minus infinit) values.
### Parameters:
* x - a vector.
### Returns:
The mean of the elements.
"""
function finiteMean(x)
    mean(x[.!isinf.(x)])
end

"""
Set the elements on the diagnoal to the value.
### Parameters:
* X - A squared matrix.
* val - A value, deafult to 0.
### Returns:
nothing
"""
function set_diag!(X, val=0.)
    if eltype(X) != typeof(val)
        throw(ErrorException("Type of element of the given matrix does not match the type of
        the given value"))
    end
    N = size(X)[1]
    assert(N == size(X)[2]) # Squared matrix
    for i in 1:N
        X[i,i]=val
    end
    return
end

"""
Standarize a vector to have mean 0 and standard deviation of 1.
Done by reducing the mean and dividing by the standard deviation for each
    element.
# Args:
* v - a vector
# Returns:
A normalized vector of the same length.
"""
function standardize(v)
    sdv = std(v)
    if (sdv == 0)
        sdv = 1
    end
    (v.-mean(v))./sdv
end

"""
Apply a function to each column of a DataFrame.
    # Args:
    * df - A DataFrame
    * func - A function
    # Returns:
    A matrix where the function func was applyied to each column of df.
"""
function sapply_df(df, func)
    v = colwise(func,df)
    #DataFrame(eltype(v[1])[el[1] for el in v])
    hcat([v[i][1] for i in 1:size(v)[1]]...)
end

"""
Return the index of maximum for each row/column
If dim=1 returned value has the length of size(A)[1]
dim=1 for rows' maximums, and 2 for columns' maximums.
    # Args:
    * A - Matrix
    * dim - The dimenssion on which to evaluate. dim=1 (default) returns \
     the index of column with maximal value.
# Returns:
A vector
"""
function max_inds(A, dim=1)
    vals, inds = findmax(A', dim)
    map(x->ind2sub(A', x)[dim], inds)
end
