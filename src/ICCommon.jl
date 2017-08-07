__precompile__(true)
module ICCommon
import ZMQ

include("instrument.jl")
include("sweep/sweep.jl")
include("interface.jl")

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
#
# @enum SweepStatus Waiting Running Aborted Done
#
# """
# ```
# @enum SweepStatus Waiting Running Aborted Done
# ```
#
# Sweep statuses are represented with an enum.
#
# ```jldoctest
# julia> InstrumentControl.SweepStatus
# Enum InstrumentControl.SweepStatus:
# Waiting = 0
# Running = 1
# Aborted = 2
# Done = 3
# ```
# """
# SweepStatus

end # module
