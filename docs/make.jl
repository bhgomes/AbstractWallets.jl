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
    pages     = Any["Home" => "index.md",],
)

deploydocs(
    repo = "github.com/bhgomes/AbstractWallets.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)
