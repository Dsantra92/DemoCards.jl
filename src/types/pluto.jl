const pluto_footer = raw"""

---

*This page was generated using [DemoCards.jl](https://github.com/johnnychen94/DemoCards.jl).*


"""

"""
    struct PlutoDemoCard <: AbstractDemoCard
    PlutoDemoCard(path::String)

Constructs a markdown-format demo card from existing markdown file `path`.


# Fields

Besides `path`, this struct has some other fields:

* `path`: path to the source markdown file
* `cover`: path to the cover image
* `id`: cross-reference id
* `title`: one-line description of the demo card
* `author`: author(s) of this demo.
* `date`: the update date of this demo.
* `pluto`: the version number of pluto used in the original demo.
* `description`: multi-line description of the demo card
* `hidden`: whether this card is shown in the generated index page

# Configuration

You can pass additional information by adding a YAML front matter to the markdown file.
Supported items are:

* `cover`: an URL or a relative path to the cover image. If not specified, it will use the first available image link, or all-white image if there's no image links.
* `description`: a multi-line description to this file, will be displayed when the demo card is hovered. By default it uses `title`.
* `id`: specify the `id` tag for cross-references. By default it's infered from the filename, e.g., `simple_demo` from `simple demo.md`.
* `title`: one-line description to this file, will be displayed under the cover image. By default, it's the name of the file (without extension).
* `author`: author name. If there are multiple authors, split them with semicolon `;`.
* `date`: any string contents that can be passed to `Dates.DateTime`. For example, `2020-09-13`.
* `hidden`: whether this card is shown in the layout of index page. The default value is `false`.

An example of the front matter:

```text
---
title: passing extra information
cover: cover.png
id: non_ambiguious_id
author: Jane Doe; John Roe
date: 2020-01-31
description: this demo shows how you can pass extra demo information to DemoCards package. All these are optional.
hidden: false
---
```

See also: [`JuliaDemoCard`](@ref DemoCards.JuliaDemoCard), [`DemoSection`](@ref DemoCards.DemoSection), [`DemoPage`](@ref DemoCards.DemoPage)
"""
mutable struct PlutoDemoCard <: AbstractDemoCard
    path::String
    cover::Union{String, Nothing}
    id::String
    title::String
    description::String
    author::String
    date::DateTime
    julia::Union{Nothing, VersionNumber}
    hidden::Bool
end

function PlutoDemoCard(path::String)::PlutoDemoCard
    # first consturct an incomplete democard, and then load the config
    card = PlutoDemoCard(path, "", "", "", "", "", DateTime(0), JULIA_COMPAT, false)

    # config = parse(card)
    # card.cover = load_config(card, "cover"; config=config)
    # card.title = load_config(card, "title"; config=config)
    # card.date = load_config(card, "date"; config=config)
    # card.author = load_config(card, "author"; config=config)
    # card.julia = load_config(card, "julia"; config=config)
    # # default id requires a title
    # card.id    = load_config(card, "id"; config=config)
    # # default description requires a title
    # card.description = load_config(card, "description"; config=config)
    # card.hidden = load_config(card, "hidden"; config=config)

    return card
end


"""
    save_democards(card_dir::String, card::JuliaDemoCard;
                   project_dir,
                   src,
                   credit,
                   nbviewer_root_url)

process the original julia file and save it.

The processing pipeline is:

1. preprocess and copy source file
2. generate ipynb file
3. generate markdown file
4. insert header and footer to generated markdown file
"""
function save_democards(card_dir::String,
                        card::PlutoDemoCard;
                        credit,
                        nbviewer_root_url,
                        project_dir=Base.source_dir(),
                        src="src",
                        throw_error = false,
                        properties = Dict{String, Any}(),
                        kwargs...)
    if !isabspath(card_dir)
      card_dir = abspath(card_dir)
    end
    isdir(card_dir) || mkpath(card_dir)
    @debug card.path
    cardname = splitext(basename(card.path))[1]
    curr_dir = pwd()
    src_dir = dirname(card.path)
    md_src_path = joinpath(src_dir, "$(cardname).md")
    card_path = joinpath(card_dir, "$(cardname).md")

    if VERSION < card.julia
        # It may work, it may not work; I hope it would work.
        @warn "The running Julia version `$(VERSION)` is older than the declared compatible version `$(card.julia)`. You might need to upgrade your Julia."
    end

    cd(src_dir)

    oopts = OutputOptions(; append_build_context=false)
    output_format = documenter_output
    # The card_dir is deleted, so keep the md files in
    # the pluto directory to save some time.
    bopts = BuildOptions(src_dir;previous_dir=src_dir,
                         output_format=output_format)
    build_notebooks(bopts, oopts)

    cd(curr_dir)
    @debug curr_dir
    cp(md_src_path, card_path;force=false)

    return nothing
end

function make_badges(card::PlutoDemoCard; src, card_dir, nbviewer_root_url, project_dir, build_notebook)
    # cardname = splitext(basename(card.path))[1]
    # badges = ["#md #"]
    # push!(badges, "[![Source code]($download_badge)]($(cardname).jl)")

    # if build_notebook
    #     if !isempty(nbviewer_root_url)
    #         # Note: this is only reachable in CI environment
    #         nbviewer_folder = normpath(relpath(card_dir, "$project_dir/$src"))
    #         nbviewer_url = replace("$(nbviewer_root_url)/$(nbviewer_folder)/$(cardname).ipynb", Base.Filesystem.path_separator=>'/')
    #     else
    #         nbviewer_url = "$(cardname).ipynb"
    #     end
    #     push!(badges, "[![notebook]($nbviewer_badge)]($nbviewer_url)")
    # end
    # if card.julia != JULIA_COMPAT
    #     # It might be over verbose to insert a compat badge for every julia card, only add one for
    #     # cards that users should care about
    #     # Question: Is this too conservative?
    #     push!(badges, "![compat](https://img.shields.io/badge/julia-$(card.julia)-blue.svg)")
    # end

    # push!(badges, invoke(make_badges, Tuple{AbstractDemoCard}, card))

    badges = ["#md #"]
    join(badges, " ")
end
