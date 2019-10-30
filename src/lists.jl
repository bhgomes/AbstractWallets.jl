# src/lists.jl
# Whitelists/Blacklists for Wallets

include("wallets.jl")

export lists,
       listtags,
       list,
       enlist!,
       swaplist!,
       onlist,
       delist!,
       whitelist,
       whitelist!,
       onwhitelist,
       blacklist,
       blacklist!,
       onblacklist


"""```
StringLike === Union{Symbol, <: AbstractString}
```
`String`-like objects are either `Symbol`s or `AbstractString`s.
"""
const StringLike = Union{Symbol, <: AbstractString}


"""```
lists(wallet::AbstractWallet)
```
Return all the lists on the wallet.
"""
function lists(wallet::AbstractWallet)
    missing_api("lists", wallet)
end


"""```
listtags(wallet::AbstractWallet)
```
Return the tags for all lists on the `wallet`.
"""
function listtags(wallet::AbstractWallet)
    missing_api("listtags", wallet)
end


"""```
list(wallet::AbstractWallet, tag::StringLike)
```
Return specific list from `wallet` corresponding to `tag`.
"""
function list(wallet::AbstractWallet, tag::StringLike)
    return lists(wallet)[tag]
end


"""```
enlist!(wallet::AbstractWallet, target::AbstractWalletOrAddress, tag)
```
Add `target` to the `tag` list on the given `wallet`.
"""
function enlist!(
    wallet::AbstractWallet,
    target::AbstractWalletOrAddress,
    tag::StringLike
)
    missing_api("enlist", wallet, target, tag)
end


"""```
swaplist!(wallet::AbstractWallet, target::AbstractWalletOrAddress, tag1, tag2)
```
Swap `target` from `tag1` list to `tag2` list in `wallet`.
"""
function swaplist!(
    wallet::AbstractWallet,
    target::AbstractWalletOrAddress,
    tag1::StringLike=:black,
    tag2::StringLike=:white
)
    if onlist(wallet, target, tag1)
        delist!(wallet, target, tag1)
        enlist!(wallet, target, tag2)
    elseif onlist(wallet, target, tag2)
        delist!(wallet, target, tag2)
        enlist!(wallet, target, tag1)
    else
        throw(ArgumentError(
            "`$target` was not on `$tag1` or `$tag2` lists in `$wallet`"))
    end
end


"""```
onlist(wallet::AbstractWallet, target::AbstractWalletOrAddress, tag)
```
Check if `target` is on the `tag` list on the given `wallet`.
"""
function onlist(
    wallet::AbstractWallet,
    target::AbstractWalletOrAddress,
    tag::StringLike
)::Bool
    return target in list(wallet, tag)
end


"""```
delist!(wallet::AbstractWallet, target::AbstractWalletOrAddress, tag::StringLike)
```
Remove `target` from `tag` list on the `wallet`.
"""
function delist!(
    wallet::AbstractWallet,
    target::AbstractWalletOrAddress,
    tag::StringLike
)
    missing_api("delist!", wallet, target, tag)
end


"""```
delist!(wallet::AbstractWallet, target::AbstractWalletOrAddress)
```
Remove `target` from any list on the `wallet`.
"""
function delist!(wallet::AbstractWallet, target::AbstractWalletOrAddress)
    missing_api("delist!", wallet, target)
end


"""```
whitelist(wallet::AbstractAddress)
```
Returns current whitelist for the given `wallet`.
"""
function whitelist(wallet::AbstractWallet)
    return list(wallet, :white)
end


"""```
whitelist!(wallet::AbstractWallet, target::AbstractWalletOrAddress)
```
Add `target` to the `wallet` whitelist.
"""
function whitelist!(wallet::AbstractWallet, target::AbstractWalletOrAddress)
    return enlist!(wallet, target, :white)
end


"""```
onwhitelist(wallet::AbstractWallet, target::AbstractWalletOrAddress)
```
Check if `target` is on the `wallet` whitelist.
"""
function onwhitelist(
    wallet::AbstractWallet,
    target::AbstractWalletOrAddress
)::Bool
    return onlist(wallet, target, :white)
end


"""```
blacklist(wallet::AbstractAddress)
```
Returns current blacklist for the given `wallet`.
"""
function blacklist(wallet::AbstractWallet)
    return list(wallet, :black)
end


"""```
blacklist!(wallet::AbstractWallet, target::AbstractWalletOrAddress)
```
Add `target` to the `wallet` blacklist.
"""
function blacklist!(wallet::AbstractWallet, target::AbstractWalletOrAddress)
    return enlist!(wallet, target, :black)
end


"""```
onblacklist(wallet::AbstractWallet, target::AbstractWalletOrAddress)
```
Check if `target` is on the `wallet` blacklist.
"""
function onblacklist(
    wallet::AbstractWallet,
    target::AbstractWalletOrAddress
)::Bool
    return onlist!(wallet, target, :black)
end
