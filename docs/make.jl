# docs/make.jl
# Make Documentation for AbstractWallets.jl

push!(LOAD_PATH, "../src/")

using Documenter, AbstractWallets

makedocs(
    modules   = [AbstractWallets],
    doctest   = true,
    clean     = false,
    linkcheck = false,
    format    = Documenter.HTML(prettyurls=!("local" in ARGS)),
    sitename  = "AbstractWallets.jl",
    authors   = "Brandon H Gomes",
    pages     = [
        "Home" => "index.md",
        "Implementing Wallet API" => [
            "Guide" => "impl/guide.md",
            "Example Projects" => "impl/examples.md",
        ],
        "Library" => [
            "Wallets and Portfolios" => "lib/wallets.md",
            "Transactions" => "lib/transactions.md",
            "Custom Wallet Lists" => "lib/lists.md",
        ]
    ],
)

deploydocs(
    repo = "github.com/bhgomes/AbstractWallets.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)
