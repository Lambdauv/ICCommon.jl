__precompile__(true)
module ICCommon

export PlotSetup, PlotPoint
export NewJobRequest, UpdateJobRequest

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

type NewJobRequest
    args::Dict
end
NewJobRequest(;kwargs...) = NewJobRequest(Dict(kwargs))

type UpdateJobRequest
    job_id::Int
    args::Dict
end
UpdateJobRequest(job_id; kwargs...) = UpdateJobRequest(job_id, Dict(kwargs))

end # module
