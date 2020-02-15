# DemoCards

| **Documentation**                                                               | **Build Status**                                                                                |
|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-dev-img]][docs-dev-url] | [![][action-img]][action-url] [![][pkgeval-img]][pkgeval-url] [![][codecov-img]][codecov-url] |

This package is used to *dynamically* generate a demo page and integrate with [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl).

_Let's focus on writing demos_

## Overview

* a plugin package to `Documenter.jl` to manage all your demos.
* folder structure is demo structure.
* minimal configuration.
* all demos can be tested by CI.
* support demos in markdown and julia format.

Organize your folders in the following way, and let `DemoCards.jl` manage the demo page for you.

```text
docs/demos/simplest_demopage
└── examples
    ├── part1
    │   ├── assets
    │   ├── demo_1.md
    │   ├── demo_2.md
    │   └── demo_3.md
    └── part2
        ├── assets
        ├── demo_4.jl
        └── demo_5.jl
```

Read the [Quick Start](https://johnnychen94.github.io/DemoCards.jl/stable/democards/quickstart/index.html) for more instructions.

# Caveat Emptor

The use of this package heavily relies on [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl),
[Literate.jl](https://github.com/fredrikekre/Literate.jl), [Mustache.jl](https://github.com/jverzani/Mustache.jl)
and others. Unfortunately, I'm not a contributor of any. This package also uses a lot of Regex, which I know little.

The initial purpose of this package is to set up the [demo page](https://juliaimages.org/latest/democards/examples) of JuliaImages.
I'm not sure how broadly this package suits the need of others, but I'd like to accept any issues/PRs on improving the usage experience.


[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://johnnychen94.github.io/DemoCards.jl/dev

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://johnnychen94.github.io/DemoCards.jl/stable

[action-img]: https://github.com/johnnychen94/DemoCards.jl/workflows/Unit%20test/badge.svg
[action-url]: https://github.com/johnnychen94/DemoCards.jl/actions

[codecov-img]: https://codecov.io/gh/johnnychen94/DemoCards.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/johnnychen94/DemoCards.jl

[pkgeval-img]: https://juliaci.github.io/NanosoldierReports/pkgeval_badges/D/DemoCards.svg
[pkgeval-url]: https://juliaci.github.io/NanosoldierReports/pkgeval_badges/report.html
