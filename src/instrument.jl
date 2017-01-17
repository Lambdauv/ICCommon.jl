export Instrument, InstrumentProperty
export RemoteInstrument

abstract Instrument
abstract InstrumentProperty

immutable RemoteInstrument
    alias::String
end
