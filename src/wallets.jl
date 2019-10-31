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
Abstraction for asset container addresses.
"""
abstract type AbstractAddress end


"""```
```
"""
abstract type AbstractPortfolio{K,N} <: AbstractDict{K,N} end


"""```
AbstractWallet{K, N, P <: AbstractPortfolio{K, N}, A <: AbstractAddress}
```
"""
abstract type AbstractWallet{K,N,P<:AbstractPortfolio{K,N},A<:AbstractAddress} end


"""```
AbstractWalletOrAddress === Union{<: AbstractWallet, <: AbstractAddress}
```
"""
const AbstractWalletOrAddress = Union{<:AbstractWallet,<:AbstractAddress}


"""```
portfoliotype(::Type{AbstractWallet{K, N, P, A}}) === P
```
Return portfolio type for a given wallet.
"""
portfoliotype(::Type{AbstractWallet{K,N,P,A}}) where {K,N,P,A} = P


"""```
portfoliotype(::AbstractWallet{K, N, P, A}) === A
```
Return portfolio type for a given wallet.
"""
portfoliotype(wallet::AbstractWallet) = portfoliotype(typeof(wallet))


"""```
portfolio(wallet::AbstractWallet) <: AbstractPortfolio
```
Return `portfolio` of `wallet` for depositing.
"""
function portfolio(wallet::AbstractWallet{K,N,P})::P where {K,N,P}
    missing_api("portfolio", wallet)
end


"""```
addresstype(::Type{AbstractWallet{K, N, P, A}}) === A
```
Return address type for a given wallet.
"""
addresstype(::Type{AbstractWallet{K,N,P,A}}) where {K,N,P,A} = A


"""```
addresstype(::AbstractWallet{K, N, P, A}) === A
```
Return address type for a given wallet.
"""
addresstype(wallet::AbstractWallet) = addresstype(typeof(wallet))


"""```
address(wallet::AbstractWallet) <: AbstractAddress
```
Return `address` of `wallet` for depositing.
"""
function address(wallet::AbstractWallet{K,N,P,A})::A where {K,N,P,A}
    missing_api("address", wallet)
end
