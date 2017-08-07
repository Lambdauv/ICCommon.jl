export RandomResponse

"""
```
struct RandomResponse <: Response end
```

Random number response suitable for testing the measurement code without having
a physical instrument.
"""
struct RandomResponse <: Response end

"""
```
measure(ch::RandomResponse)
```

Returns a random number in the unit interval.
"""
measure(ch::RandomResponse) = rand()
