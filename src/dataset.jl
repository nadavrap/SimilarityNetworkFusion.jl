"""
Load a data set from package.
# Args:
* name - A string name of data set.
# Returns:
List of DataFrames with the data.
"""
function dataset(name)
    datadir = joinpath(dirname(@__FILE__), "..", "data", name)
    if !ispath(datadir)
        error(@sprintf "Unable to locate data %s\n" name)
    else
        files = readdir(datadir)
        return [CSV.read(joinpath(datadir, fname), delim=' ', nullable=false) for fname in files]
    end
end
