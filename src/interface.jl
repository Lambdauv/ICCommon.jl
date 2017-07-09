# Job requests

type WithJobRequest
    fn::Symbol
    job_id::Int
end

type AbortJobRequest
    job_id::Int
end

type NewJobRequest
    args::Dict
end
NewJobRequest(;kwargs...) = NewJobRequest(Dict(kwargs))

type UpdateJobRequest
    job_id::Int
    args::Dict
end
UpdateJobRequest(job_id; kwargs...) = UpdateJobRequest(job_id, Dict(kwargs))

type ListJobsRequest end

# User requests

type ListUsersRequest end

type ArchiveRequest
    data::Dict
end

# Instrument requests

type ListInstrumentsRequest end

# Plotting requests

type PlotSetup
    arrtype
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
