# Job requests

mutable struct WithJobRequest
    fn::Symbol
    job_id::Int
end

mutable struct AbortJobRequest
    job_id::Int
end

mutable struct NewJobRequest
    args::Dict
end
NewJobRequest(;kwargs...) = NewJobRequest(Dict(kwargs))

mutable struct UpdateJobRequest
    job_id::Int
    args::Dict
end
UpdateJobRequest(job_id; kwargs...) = UpdateJobRequest(job_id, Dict(kwargs))

struct ListJobsRequest end

# User requests

struct ListUsersRequest end

mutable struct ArchiveRequest
    data::Dict
end

# Instrument requests

struct ListInstrumentsRequest end

# Plotting requests

mutable struct PlotSetup
    arrtype
    size::Tuple
    kwargs::Dict
end

function PlotSetup(a,b; kwargs...)
    argdict = Dict(k=>v for (k,v) in kwargs)
    PlotSetup(a,b,argdict)
end

mutable struct PlotPoint
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
