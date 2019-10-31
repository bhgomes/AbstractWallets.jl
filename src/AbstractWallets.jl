# src/AbstractWallets.jl
# Abstract Digital Wallets

__precompile__(true)

"""```
AbstractWallets
```
Abstractions Module for Digital Wallets.
"""
module AbstractWallets

include("wallets.jl")
include("portfolios.jl")
include("transactions.jl")
include("lists.jl")

end  # module AbstractWallets
