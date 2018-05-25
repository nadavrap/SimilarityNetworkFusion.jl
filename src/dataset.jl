using CSV

"""
Load a data set from package.
# Args:
* name - A string name of data set.
# Returns:
List of DataFrames with the data.
"""
function dataset(name)
    # TCGA data was originally given in a subjects as columns format. I found
    # the easiest way to transfer with R. So I run the next command:
    # > for f in */*.txt; do
    #   o=`echo $f | sed s'/txt/csv/'`
    #   R --silent -e "write.table(t(read.table('$f', skip = 1, header = FALSE)), file='$o', quote = FALSE, col.names = FALSE, row.names = FALSE)"; done
    datadir = joinpath(dirname(@__FILE__), "..", "data", name)
    if !ispath(datadir)
        error(@sprintf "Unable to locate data %s\n" name)
    else
        files = readdir(datadir)
        if name == "Simulation1"
            return [CSV.read(joinpath(datadir, fname), delim=' ', nullable=false) for fname in files]
        else
            data = [readdlm(joinpath(datadir,fname), header=true)[1] for fname in files if !endswith(fname, "_Survival.csv")]
            outcomes = [readdlm(joinpath(datadir,fname), header=true)[1] for fname in files if endswith(fname, "_Survival.csv")][1]
            return (data, outcomes)
        end
    end
end
