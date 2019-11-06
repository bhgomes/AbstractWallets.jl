<div align="center">

# AbstractWallets.jl

[![Stable Docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://bhgomes.github.io/AbstractWallets.jl/stable)
[![Latest Docs](https://img.shields.io/badge/docs-latest-blue.svg)](https://bhgomes.github.io/AbstractWallets.jl/latest)
[![Travis Build Status](https://travis-ci.com/bhgomes/AbstractWallets.jl.svg?branch=master)](https://travis-ci.com/bhgomes/AbstractWallets.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/pinmr5hvxo04uahp?svg=true)](https://ci.appveyor.com/project/bhgomes/abstractwallets-jl)
[![Formatting](https://img.shields.io/badge/format-tab%204%20margin%2096-888)](https://github.com/domluna/JuliaFormatter.jl)
[![GitHub Repo](https://img.shields.io/badge/repo-GitHub-black)](https://github.com/bhgomes/AbstractWallets.jl)

_Abstractions for Digital Wallets in Julia_

</div>

## Installation

To install open a Julia REPL and run the following:

```julia
]add AbstractWallets
```

## Basic API

The `AbstractWallets` API defines the following basic structures:

| Type | Description |
|------|-------------|
| `AbstractAddress` | Abstraction over digital addresses. |
| `AbstractPortfolio` | A container of assets with methods for evaluating their value relative to other assets. |
| `AbstractWallet` | A wallet is a portfolio with a digital address to identify it. |

### Transactions

Transactions between digital wallets or from wallets to addresses is mediated by the `AbstractTransaction` type. Transactions can take the two generic forms

| Form | Description |
|------|-------------|
| `AbstractSendTransaction` | Results in the movement of assets from one party to another. |
| `AbstractDestroyTransaction` | Results in the net destruction of assets. |

which can be mediated by the two generic transaction functions:

| Action | Constructor |
|--------|-------------|
| `send!` | `build_send_transaction` |
| `destroy!` | `build_destroy_transaction` |

To use more advanced transaction types we have the following states:

| State | Description |
|-------|-------------|
| `is_pending` | Transaction is waiting to complete. |
| `has_executed` | Transaction was executed but not necessarily completed. It is at least pending. |
| `was_completed` | Transaction was executed and completed. |
| `was_cancelled` | Transaction was cancelled before completion. |
| `failed` | Transaction failed to complete, but was not cancelled. |

and the allowed actions:

| Action | Description |
|--------|-------------|
| `sign!` | Signatures on a transaction verify that it should be executed. |
| `execute!` | Execution of a transaction is the attempt to perform the appropriate transfer of assets defined in the transaction. |
| `cancel!`| Stop a pending transaction. |
| `rollback!` | Reset a completed transaction to return the state of the associated portfolios to before the transaction occured. |
| `cancelback!` | Cancel and then roll back the transaction. |

## Crypto-Specific API

### Private Keys

For cryptocurrency wallets and other wallets protected by asymmetric-cryptography, public-private key pairs are the method with which wallets can identify themselves. To access the keys, use either the `keypairs(wallet)` function or the `privatekey(wallet, publickey)`.

### Deterministic Wallets

A deterministic wallet can generate new public-private key pairs from one root private key. Such wallets are represented by the `AbstractDeterministicWallet` type. Use `rootkey`, `mnemonic`, or `seed` to access the root private key, and `next_keypair!` or `next_address!` to generate the next key.

---
<div align="center">

#### [(UN)LICENSE](UNLICENSE)
Knowledge is Freedom.
</div>
