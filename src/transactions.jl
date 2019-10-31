# src/transactions.jl
# Transaction API for Wallets

export AbstractTransaction,
       AbstractSendTransaction,
       AbstractDestroyTransaction,
       statetype,
       stateof,
       history,
       transactions_between,
       withdrawls,
       deposits,
       build_send_transaction,
       build_destroy_transaction,
       execute!,
       cancel!,
       rollback!,
       cancelback!,
       has_executed,
       is_pending,
       was_fulfilled,
       was_cancelled,
       failed,
       send!,
       destroy!


"""```
AbstractTransaction{S}
```
Abstraction for Transactions with state type `S`.
"""
abstract type AbstractTransaction{S} end


"""```
AbstractSendTransaction{S} <: AbstractTransaction{S}
```
Abstraction for Transactions which transfer assets.
"""
abstract type AbstractSendTransaction{S} <: AbstractTransaction{S} end


"""```
AbstractDestroyTransaction{S} <: AbstractTransaction{S}
```
Abstraction for Transactions which destroy assets.
"""
abstract type AbstractDestroyTransaction{S} <: AbstractTransaction{S} end


"""```
statetype(::Type{AbstractTransaction{S}}) === S
```
Return the state type `S` of the Transaction abstraction.
"""
statetype(::Type{AbstractTransaction{S}}) where {S} = S


"""```
statetype(::AbstractTransaction{S}) === S
```
Return the state type `S` of the Transaction abstraction.
"""
statetype(transaction::AbstractTransaction) = statetype(typeof(transaction))


"""```
stateof(transaction::AbstractTransaction{S})::S
```
Return the current state (of type `S`) of the transaction.
"""
function stateof(transaction::AbstractTransaction{S})::S where {S}
    missing_api("stateof", transaction)
end


"""```
history(wallet::AbstractWallet)
```
Return the transaction history of the given `wallet`.
"""
function history(wallet::AbstractWallet)
    missing_api("history", wallet)
end


"""```
transactions_between(source::AbstractWallet, target::AbstractWalletOrAddress)
```
Return all transactions between `source` and `target`.
"""
function transactions_between(
    source::AbstractWallet,
    target::AbstractWalletOrAddress
)
    missing_api("transactions_between", source, target)
end


"""```
transactions_between(source::AbstractWalletOrAddress, target::AbstractWallet)
```
Return all transactions between `source` and `target`.
"""
function transactions_between(
    source::AbstractWalletOrAddress,
    target::AbstractWallet
)
    missing_api("transactions_between", source, target)
end


"""```
withdrawls(wallet::AbstractWalletOrAddress, target::AbstractWallet)
```
Return all send transactions to `target` from `wallet`.
"""
function withdrawls(
    wallet::AbstractWallet,
    target::AbstractWalletOrAddress
)
    missing_api("withdrawls", wallet, target)
end


"""```
withdrawls(wallet::AbstractWallet)
```
Return all withdrawls out of `wallet`.
"""
function withdrawls(wallet::AbstractWallet)
    missing_api("withdrawls", wallet)
end


"""```
deposits(wallet::AbstractWalletOrAddress, source::AbstractWallet)
```
Return all send transactions from `source` to `wallet`.
"""
function deposits(
    wallet::AbstractWallet,
    source::AbstractWalletOrAddress
)
    missing_api("deposits", wallet, source)
end


"""```
deposits(wallet::AbstractWallet)
```
Return all deposits into `wallet`.
"""
function deposits(wallet::AbstractWallet)
    missing_api("deposits", wallet)
end


"""```
build_send_transaction(source::AbstractWallet, target, asset, quantity;
                       fulfill_maximum=false)
```
Prepare transaction which will send a certain amount of the given `asset` to
the `target` if it is contained in this `quantity` in the original `wallet`.
If `fulfill_maximum` is `true`, then fulfill as much of the transaction as
possible.
"""
function build_send_transaction(
    source::AbstractWallet{K, N},
    target::AbstractWalletOrAddress,
    asset::K,
    quantity::N;
    fulfill_maximum=false
)::AbstractSendTransaction where {K, N}
    missing_api("build_send_transaction",
        source, target, asset, quantity; fulfill_maximum=fulfill_maximum
    )
end


"""```
build_destroy_transaction(wallet::AbstractWallet, asset, quantity;
                          fulfill_maximum=false)
```
Prepare transaction which will destroy a certain amount of the given `asset` if
it is contained in this `quantity` in the original `wallet`. If
`fulfill_maximum` is `true`, then fulfill as much of the transaction as
possible.
"""
function build_destroy_transaction(
    wallet::AbstractWallet{K, N},
    asset::K,
    quantity::N;
    fulfill_maximum=false
)::AbstractDestroyTransaction where {K, N}
    missing_api("build_destroy_transaction",
        wallet, asset, quantity, fulfill_maximum=fulfill_maximum
    )
end


"""```
execute!(transaction::AbstractTransaction)
```
Execute the given `transaction` and wait for a return signal.
"""
function execute!(transaction::AbstractTransaction)
    missing_api("execute!", transaction)
end


"""```
cancel!(transaction::AbstractTransaction)
```
Cancel a pending transaction.
"""
function cancel!(transaction::AbstractTransaction)
    missing_api("cancel!", transaction)
end


"""```
rollback!(transaction::AbstractTransaction)
```
Rollback a completed transaction.
"""
function rollback!(transaction::AbstractTransaction)
    missing_api("rollback!", transaction)
end


"""```
cancelback!(transaction::AbstractTransaction; onsuccess, onfailure)
```
Rollback a fulfilled transaction or cancel a pending one.
"""
function cancelback!(
    transaction::AbstractTransaction;
    onsuccess=identity,
    onfailure=identity
)
    if was_fulfilled(transaction)
        return rollback!(transaction)
    elseif is_pending(transaction)
        return cancel!(transaction)
    elseif was_cancelled(transaction)
        return onsuccess(transaction)
    else
        return onfailure(transaction)
    end
end


"""```
has_executed(transaction::AbstractTransaction)::Bool
```
Check if `transaction` has been executed.
"""
function has_executed(transaction::AbstractTransaction)::Bool
    missing_api("has_executed", transaction)
end


"""```
is_pending(transaction::AbstractTransaction)::Bool
```
Check if `transaction` has been executed but is pending.
"""
function is_pending(transaction::AbstractTransaction)::Bool
    missing_api("is_pending", transaction)
end


"""```
was_fulfilled(transaction::AbstractTransaction)::Bool
```
Check if `transaction` was fulfilled.
"""
function was_fulfilled(transaction::AbstractTransaction)::Bool
    missing_api("was_fulfilled", transaction)
end


"""```
was_cancelled(transaction::AbstractTransaction)::Bool
```
Check if `transaction` was forcibly cancelled.
"""
function was_cancelled(transaction::AbstractTransaction)::Bool
    missing_api("was_cancelled", transaction)
end


"""```
failed(transaction::AbstractTransaction)::Bool
```
Check if `transaction` failed.
"""
function failed(transaction::AbstractTransaction)::Bool
    missing_api("failed", transaction)
end


"""```
send!(source::AbstractWallet, target, asset, quantity;
      fulfill_maximum=false, check, onfailure)
```
Send a certain amount of the given asset to a target if it is contained in this
quantity in the original wallet. If `fulfill_maximum` is `true`, then fulfill
as much of the transaction as possible.
"""
function send!(
    source::AbstractWallet{K, N},
    target::AbstractWalletOrAddress,
    asset::K,
    quantity::N;
    fulfill_maximum=false,
    check=x->true,
    onfailure=identity
) where {K, N}
    transaction = build_send_transaction(source, target, asset, quantity;
        fulfill_maximum=fulfill_maximum
    )
    if !check(transaction)
        return onfailure(transaction)
    end
    return execute!(transaction)
end


"""```
destroy!(wallet::AbstractWallet, asset, quantity;
         fulfill_maximum=false, check, onfailure)
```
Destroy a certain amount of the given asset if it is contained in the wallet.
If `fulfill_maximum` is `true`, then fulfill as much of the transaction as
possible.
"""
function destroy!(
    wallet::AbstractWallet{K, N},
    asset::K,
    quantity::N;
    fulfill_maximum=false,
    check=x->true,
    onfailure=identity
) where {K, N}
    transaction = build_destroy_transaction(wallet, asset, quantity;
        fulfill_maximum=fulfill_maximum
    )
    if !check(transaction)
        return onfailure(transaction)
    end
    return execute!(transaction)
end
