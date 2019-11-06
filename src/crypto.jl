# src/crypto.jl
# Cryptocurrency Wallet Extras

export AbstractPublicKey,
       keypairs,
       privatekey,
       AbstractDeterministicWallet,
       rootkey,
       mnemonic,
       seed,
       next_keypair!,
       next_address!


"""```
AbstractPublicKey <: AbstractAddress
```
Public Keys for Wallets are Addresses.
"""
abstract type AbstractPublicKey <: AbstractAddress end


"""```
keypairs(wallet::AbstractWallet)
```
Return public-private key pairs that identify the given `wallet`.
"""
function keypairs(wallet::AbstractWallet)
    missing_api("keypairs", wallet)
end


"""```
privatekey(wallet::AbstractWallet, key::AbstractPublicKey)
```
Return the private key corresponding to the `publickey` in `wallet`.
"""
function privatekey(wallet::AbstractWallet, publickey::AbstractPublicKey)
    missing_api("privatekey", wallet, publickey)
end


"""```
AbstractDeterministicWallet <: AbstractWallet
```
Wallets where addresses can be computed deterministically from a seed.
"""
abstract type AbstractDeterministicWallet{K,N,P,A<:AbstractPublicKey} <: AbstractWallet{K,N,P,A} end


"""```
rootkey(wallet::AbstractDeterministicWallet)
```
The root private key for determining wallet addresses.
"""
function rootkey(wallet::AbstractDeterministicWallet)
    missing_api("rootkey", wallet)
end


"""```
mnemonic(wallet::AbstractDeterministicWallet)
```
Human-readable mnemonic representing the root private key.
"""
function mnemonic(wallet::AbstractDeterministicWallet)
    missing_api("mnemonic", wallet)
end


"""```
seed(wallet::AbstractDeterministicWallet)
```
Human-readable seed representing the root private key.
"""
function seed(wallet::AbstractDeterministicWallet)
    return mnemonic(wallet)
end


"""```
next_keypair!(wallet::AbstractDeterministicWallet)
```
Produce the next key pair in the deterministic wallet.
"""
function next_keypair!(wallet::AbstractDeterministicWallet)
    missing_api("next_keypair!", wallet)
end


"""```
next_address!(wallet::AbstractDeterministicWallet)::AbstractPublicKey
```
Produce the next address in the deterministic wallet. This should be the first
value in the pair produced from `next_keypair!(wallet)`.
"""
function next_address!(wallet::AbstractDeterministicWallet)::AbstractPublicKey
    return first(next_keypair!(wallet))
end
