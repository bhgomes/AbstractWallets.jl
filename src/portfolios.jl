# src/portfolios.jl
# Abstract Portfolios

export contains, quantity_contained, value_contained


"""```
contains(portfolio::AbstractPortfolio{K, N}, asset::K, quantity::N)
```
Check if the `portfolio` contains `quantity` amount of the given `asset`. 
"""
function contains(
    portfolio::AbstractPortfolio{K, N},
    asset::K,
    quantity::N
)::Bool where {K, N}
    missing_api("contains", portfolio, asset, quantity)
end


"""```
contains(wallet::AbstractWallet{K, N}, asset::K, quantity::N)
```
Check if the `wallet` contains `quantity` amount of the given `asset`. 
"""
function contains(
    wallet::AbstractWallet{K, N},
    asset::K,
    quantity::N
)::Bool where {K, N}
    return contains(portfolio(wallet), asset, quantity)
end


"""```
quantity_contained(portfolio::AbstractPortfolio{K}, asset::K)
```
Calculate the amount of `asset` contained in the `portfolio`. If the asset is not
in the wallet, a suitable null value should be returned.
"""
function quantity_contained(
    portfolio::AbstractPortfolio{K, N},
    asset::K
)::N where {K, N}
    missing_api("quantity_contained", portfolio, asset)
end


"""```
quantity_contained(wallet::AbstractWallet{K}, asset::K)
```
Calculate the amount of `asset` contained in the `wallet`. If the asset is not
in the wallet, a suitable null value should be returned.
"""
function quantity_contained(
    wallet::AbstractWallet{K, N},
    asset::K
)::N where {K, N}
    return quantity_contained(portfolio(wallet), asset)
end


"""```
value_contained(portfolio::AbstractPortfolio{K}, asset::K, base)
```
Calculate the total value of a given `asset` contained in the `portfolio` in the
given `base` asset (not necessarily contained in the `portfolio`). 
"""
function value_contained(portfolio::AbstractPortfolio{K}, asset::K, base) where {K}
    missing_api("value_contained", portfolio, asset, base)
end


"""```
value_contained(wallet::AbstractWallet{K}, asset::K, base)
```
Calculate the total value of a given `asset` contained in the `wallet` in the
given `base` asset (not necessarily contained in the `wallet`). 
"""
function value_contained(wallet::AbstractWallet{K}, asset::K, base) where {K}
    return value_contained(portfolio(wallet), asset, base)
end


"""```
value_contained(wallet::AbstractPortfolio, base)
```
Calculate the total value contained in the `portfolio` in the given `base` asset
(not necessarily contained in the `portfolio`). 
"""
function value_contained(portfolio::AbstractPortfolio, base)
    return sum((asset, _) -> value_contained(portfolio, asset, base), portfolio)
end


"""```
value_contained(wallet::AbstractWallet, base)
```
Calculate the total value contained in the `wallet` in the given `base` asset
(not necessarily contained in the `wallet`). 
"""
function value_contained(wallet::AbstractWallet, base)
    return value_contained(portfolio(wallet), base)
end
