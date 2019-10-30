# src/wallets.jl
# Core Wallet API

export missing_api,
       AbstractAddress,
       AbstractWallet,
       AbstractWalletOrAddress,
       addresstype,
       address,
       contains,
       quantity_contained,
       value_contained


"""```
missing_api(name, args...; kwargs...)
```
Throw an `ArgumentError` if the function with name `name` is not defined on
the given `args` and `kwargs`.
"""
function missing_api(name::AbstractString, args...; kwargs...)
    throw(ArgumentError("`$name` is not defined for `$args, $kwargs`"))
end


"""```
AbstractAddress
```
"""
abstract type AbstractAddress end


"""```
AbstractWallet{K, V, N, A <: AbstractAddress} <: AbstractDict{K, V}
```
"""
abstract type AbstractWallet{K, V, N, A <: AbstractAddress} <: AbstractDict{K, V} end


"""```
AbstractWalletOrAddress === Union{<: AbstractWallet, <: AbstractAddress}
```
"""
const AbstractWalletOrAddress = Union{<: AbstractWallet, <: AbstractAddress}


"""```
```
"""
addresstype(::Type{AbstractWallet{K, V, N, A}}) where {K, V, N, A} = A


"""```
```
"""
addresstype(wallet::AbstractWallet) = addresstype(typeof(wallet))


"""```
address(wallet::AbstractWallet) <: AbstractAddress
```
Returns `address` of `wallet` for depositing.
"""
function address(wallet::AbstractWallet{K, V, N, A})::A where {K, V, N, A}
    missing_api("address", wallet)
end


"""```
contains(wallet::AbstractWallet{K, V, N}, asset::K, quantity::N)
```
Check if the `wallet` contains `quantity` amount of the given `asset`. 
"""
function contains(
    wallet::AbstractWallet{K, V, N},
    asset::K,
    quantity::N
) where {K, V, N}
    missing_api("contains", wallet, asset, quantity)
end


"""```
quantity_contained(wallet::AbstractWallet{K}, asset::K)
```
Calculate the amount of `asset` contained in the `wallet`. If the asset is not
in the wallet, a suitable null value should be returned.
"""
function quantity_contained(wallet::AbstractWallet{K}, asset::K) where {K}
    missing_api("quantity_contained", wallet, asset)
end


"""```
value_contained(wallet::AbstractWallet{K}, asset::K, base)
```
Calculate the total value of a given `asset` contained in the `wallet` in the
given `base` asset (not necessarily contained in the `wallet`). 
"""
function value_contained(wallet::AbstractWallet{K}, asset::K, base) where {K}
    missing_api("value_contained", wallet, asset, base)
end


"""```
value_contained(wallet::AbstractWallet, base)
```
Calculate the total value contained in the `wallet` in the given `base` asset
(not necessarily contained in the `wallet`). 
"""
function value_contained(wallet::AbstractWallet, base)
    return sum((asset, _) -> value_contained(wallet, asset, base), wallet)
end
