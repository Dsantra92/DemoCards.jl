#! /usr/bin/julia

# comments are allowed before YAML frontmatter

# ---
# title: Write your demo in julia
# id: juliademocard_example
# cover: assets/literate.png
# date: 2020-09-13
# author: "[Johnny Chen](https://github.com/johnnychen94)"
# julia: 1.0.1
# description: This demo shows you how to write your demo in julia
# ---

# Different from markdown format demo, source demo files are preprocessed so that it generates:
#
# 1. assets such as cover image
# 2. julia source file
# 3. mardkown file
# 4. jupyter notebook file
#
# Links to nbviewer and source files are provided as well.

# !!! note
#     This entails every source file being executed three times: 1) asset generation, 2) notebook
#     generation, and 3) Documenter HTML generation. If the generation time is too long for your
#     application, you could then choose to write your demo in markdown format. Or you can disable
#     the notebook generation via the `notebook` keyword in your demos, this helps reduce the
#     runtime to 2x.

#
# The conversions from source demo files to `.jl`, `.md` and `.ipynb` files are mainly handled by
# [`Literate.jl`](https://github.com/fredrikekre/Literate.jl). The syntax to control/filter the
# outputs can be found [here](https://fredrikekre.github.io/Literate.jl/stable/fileformat/)

x = 1//3
y = 2//5
x + y

#-

# Images can be loaded and displayed
using TestImages, ImageShow
img = testimage("lena")

# The frontmatter is also written in YAML with only a leading `#`, for example:

# ```
# # ---
# # title: <title>
# # cover: <cover>
# # id: <id>
# # date: 2020-09-13
# # author: Johnny Chen
# # julia: 1.3
# # description: <description>
# # ---
# ```

# In addition to the keywords supported by markdown files, Julia format demos accept one extra
# frontmatter keyword: `julia`. It allows you to specify the compat version of your demo. With this,
# `DemoCards` would:
#
#   - throw a warning if your demos are generated using a lower version of Julia
#   - insert a compat version badge.
#
# The warning is something like "The running Julia version `1.0.5` is older than the declared
# compatible version `1.3.0`."

# Another extra keyword is `notebook`, it allows you to control whether you needs to generate
# jupyter notebook `.ipynb` for the demo. The valid values are `true` and `false`. See also
# [Override default values with properties](@id page_sec_properties) on how to disable all notebook
# generation via the properties entry.

# !!! warning
#     You should be careful about the leading whitespaces after the first `#`. Frontmatter as weird as the
#     following is not guaranteed to work and it is very likely to hit a YAML parsing error.

#     ```yaml
#     #---
#     # title: <title>
#     #  cover: <cover>
#     #  id: <id>
#     # description: <description>
#     #---
#     ```

# !!! tip
#     Comments are allowed before frontmatter, but it would only be appeared in the julia source
#     codes. Normally, you may only want to add magic comments and license information before the
#     YAML frontmatter.
