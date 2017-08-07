export Instrument, InstrumentProperty
export RemoteInstrument

abstract type Instrument end
abstract type InstrumentProperty end

struct RemoteInstrument
    alias::String
end
