export reconstruct

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

# Reconstruct AxisArray from an archived dictionary.
function reconstruct(d::Dict{String,Any})
    haskey(d, "data") || error("no `data` key.")

    r = r"^axis([0-9]+)_([\s\S]+)"
    keyz = collect(keys(d))
    where = [ismatch(r, str) for str in keyz]
    matches = keyz[where]
    a = map(str->begin m = match(r,str); parse(m[1]),m[2] end, matches)
    a2 = Vector{Tuple{Symbol, Any}}(length(a))
    for (f,g) in a
        a2[f] = (Symbol(g), d["axis$(f)_$(g)"])
    end
    AxisArray(d["data"], (Axis{name}(v) for (name,v) in a2)...)
end
