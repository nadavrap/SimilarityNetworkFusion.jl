"""
Visualizes the specified clusters in an affinity matrix
# Args:
    * W: Affinity matrix
    * group: labels for each row/column in W
"""
function displayClusters(W, group)
    ind = sortperm(group)
    set_diag!(W)
    W = row_normalize(W)
    W = W + W'

    spy(W[ind, ind],
        Scale.color_continuous(colormap=Scale.lab_gradient("white", "black")),
        Guide.xlabel("Patients"),
        Guide.ylabel("Patients"))
end
