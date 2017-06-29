__precompile__(true)
module ICCommon

import ZMQ
using Compat

include("instrument.jl")
include("sweep/sweep.jl")
include("interface.jl")
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
