# Job requests

type ArchiveRequest
    data::Dict
end

# Plotting requests

type PlotSetup
    arrtype::DataType
    size::Tuple
    kwargs::Dict
end

function PlotSetup(a,b; kwargs...)
    argdict = Dict(k=>v for (k,v) in kwargs)
    PlotSetup(a,b,argdict)
end

type PlotPoint
    inds
    v
end

# Methods

# Send serialized objects
function ssend(sock, x...)
    io = IOBuffer()
    for y in x
        serialize(io, y)
    end
    ZMQ.send(sock, ZMQ.Message(io))
end

# Send shown object
function tsend(sock, x)
    io = IOBuffer()
    Base.show(io, x)
    ZMQ.send(sock, ZMQ.Message(io))
end

stdout() = Base.STDOUT
write_stdout(x) = write(stdout(), x)
