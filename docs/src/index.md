# AbstractWallets.jl

[![Travis Build Status](https://travis-ci.com/bhgomes/AbstractWallets.jl.svg?branch=master)](https://travis-ci.com/bhgomes/AbstractWallets.jl)
[![GitHub Repo](https://img.shields.io/badge/repo-GitHub-black)](https://github.com/bhgomes/AbstractWallets.jl)

_Abstractions for Digital Wallets in Julia_

```@meta
CurrentModule = AbstractWallets
```

The `AbstractWallets` package describes an API for digital asset wallets which focuses on three key properties: internal portfolio, transaction layer and transaction histories, and custom address lists (whitelist/blacklist/...). See the [Implementing Wallet API: Guide](impl/guide.md) page for more details.

To install `AbstractWallets` run the following in a Julia REPL:

```julia
]add AbstractWallets
```
