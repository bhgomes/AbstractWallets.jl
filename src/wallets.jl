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
AbstractPortfolio{K, N} <: AbstractDict{K, N}
```
Abstraction for asset container.
"""
abstract type AbstractPortfolio{K,N} <: AbstractDict{K,N} end


"""```
AbstractWallet{K, N, P <: AbstractPortfolio{K, N}, A <: AbstractAddress}
```
Abstraction for asset container with address.
"""
abstract type AbstractWallet{K,N,P<:AbstractPortfolio{K,N},A<:AbstractAddress} end


"""```
AbstractWalletOrAddress === Union{<: AbstractWallet, <: AbstractAddress}
```
A type which is either an `AbstractWallet` or an `AbstractAddress`.
"""
const AbstractWalletOrAddress = Union{<:AbstractWallet,<:AbstractAddress}


"""```
portfoliotype(::Type{AbstractWallet{K, N, P, A}}) === P
```
Return portfolio type for a given `wallet`.
"""
portfoliotype(::Type{AbstractWallet{K,N,P,A}}) where {K,N,P,A} = P


"""```
portfoliotype(::AbstractWallet{K, N, P, A}) === A
```
Return portfolio type for a given `wallet`.
"""
portfoliotype(wallet::AbstractWallet) = portfoliotype(typeof(wallet))


"""```
portfolio(wallet::AbstractWallet) <: AbstractPortfolio
```
Return the `portfolio` of a given `wallet`.
"""
function portfolio(wallet::AbstractWallet{K,N,P})::P where {K,N,P}
    missing_api("portfolio", wallet)
end


"""```
wallet(portfolio::AbstractWallet) <: AbstractWallet
```
Return the `wallet` of a given `portfolio`.
"""
function wallet(portfolio::AbstractPortfolio{K,N})::AbstractWallet{K,N,P} where {K,N,P}
    missing_api("wallet", portfolio)
end


"""```
addresstype(::Type{AbstractWallet{K, N, P, A}}) === A
```
Return address type for a given `wallet`.
"""
addresstype(::Type{AbstractWallet{K,N,P,A}}) where {K,N,P,A} = A


"""```
addresstype(::AbstractWallet{K, N, P, A}) === A
```
Return address type for a given `wallet`.
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


"""```
address(portfolio::AbstractPortfolio) <: AbstractAddress
```
Return `address` of the overlying wallet of the given `portfolio`.
"""
function address(portfolio::AbstractPortfolio)
    return address(wallet(portfolio))
end
