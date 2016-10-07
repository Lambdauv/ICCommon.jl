module ICCommon

export PlotSetup, PlotPoint

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

end
