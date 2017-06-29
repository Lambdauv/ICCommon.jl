export Instrument, InstrumentProperty
export RemoteInstrument

@compat abstract type Instrument end
@compat abstract type InstrumentProperty end

immutable RemoteInstrument
    alias::String
end
