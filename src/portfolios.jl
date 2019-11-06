# src/portfolios.jl
# Abstract Portfolios

export contains, quantity_contained, balance


"""```
contains(portfolio::AbstractPortfolio{K, N}, asset::K, quantity::N)
```
Check if the `portfolio` contains `quantity` amount of the given `asset`.
"""
function contains(portfolio::AbstractPortfolio{K,N}, asset::K, quantity::N)::Bool where {K,N}
    missing_api("contains", portfolio, asset, quantity)
end


"""```
contains(wallet::AbstractWallet{K, N}, asset::K, quantity::N)
```
Check if the `wallet` contains `quantity` amount of the given `asset`.
"""
function contains(wallet::AbstractWallet{K,N}, asset::K, quantity::N)::Bool where {K,N}
    return contains(portfolio(wallet), asset, quantity)
end


"""```
quantity_contained(portfolio::AbstractPortfolio{K}, asset::K)
```
Calculate the amount of `asset` contained in the `portfolio`. If the asset is not
in the wallet, a suitable null value should be returned.
"""
function quantity_contained(portfolio::AbstractPortfolio{K,N}, asset::K)::N where {K,N}
    missing_api("quantity_contained", portfolio, asset)
end


"""```
quantity_contained(wallet::AbstractWallet{K}, asset::K)
```
Calculate the amount of `asset` contained in the `wallet`. If the asset is not
in the wallet, a suitable null value should be returned.
"""
function quantity_contained(wallet::AbstractWallet{K,N}, asset::K)::N where {K,N}
    return quantity_contained(portfolio(wallet), asset)
end


"""```
balance(portfolio::AbstractPortfolio{K}, asset::K, base)
```
Calculate the total value of a given `asset` contained in the `portfolio` in the
given `base` asset (not necessarily contained in the `portfolio`).
"""
function balance(portfolio::AbstractPortfolio{K}, asset::K, base) where {K}
    missing_api("balance", portfolio, asset, base)
end


"""```
balance(wallet::AbstractWallet{K}, asset::K, base)
```
Calculate the total value of a given `asset` contained in the `wallet` in the
given `base` asset (not necessarily contained in the `wallet`).
"""
function balance(wallet::AbstractWallet{K}, asset::K, base) where {K}
    return balance(portfolio(wallet), asset, base)
end


"""```
balance(portfolio::AbstractPortfolio, base)
```
Calculate the total value contained in the `portfolio` in the given `base` asset
(not necessarily contained in the `portfolio`).
"""
function balance(portfolio::AbstractPortfolio, base)
    return sum((asset, _) -> balance(portfolio, asset, base), portfolio)
end


"""```
balance(wallet::AbstractWallet, base)
```
Calculate the total value contained in the `wallet` in the given `base` asset
(not necessarily contained in the `wallet`).
"""
function balance(wallet::AbstractWallet, base)
    return balance(portfolio(wallet), base)
end
