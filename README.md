<div align="center">

# AbstractWallets.jl

[![Stable Docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://bhgomes.github.io/AbstractWallets.jl/stable)
[![Latest Docs](https://img.shields.io/badge/docs-latest-blue.svg)](https://bhgomes.github.io/AbstractWallets.jl/latest)
[![Travis Build Status](https://travis-ci.com/bhgomes/AbstractWallets.jl.svg?branch=master)](https://travis-ci.com/bhgomes/AbstractWallets.jl)

_Abstractions for Digital Wallets in Julia_

</div>

## Types

The types defined in this package are the following

|Type                 |Contains                                           |Does                              |
|:-------------------:|:-------------------------------------------------:|:--------------------------------:|
|`AbstractAddress`    |address data                                       |nothing                           |
|`AbstractWallet`     |address, assets, transaction history, address lists|queried for details               |
|`AbstractTransaction`|amount and asset type, source and target addresses |transfers assets between addresses|

---
<div align="center">

#### [(UN)LICENSE](UNLICENSE)
Knowledge is Freedom.
</div>
