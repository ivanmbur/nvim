local ls = require("luasnip")
-- 's' for snippet
local s = ls.s
-- 't' for text node
local t = ls.t

return {
    s({
        trig = "mdcell",
        name = "New Markdown Cell",
        dscr = "Creates a new jupytext/quarto markdown cell",
    },
        {
            t({"# %% [markdown]", "", "# "}),
        }),

    -- Snippet 2: Code Cell
    s({
        trig = "cell",
        name = "New Code Cell",
        dscr = "Creates a new jupytext/quarto code cell",
    },
        {
            t({"# %%", "", ""})
        }),

    s("psi", t("ψ") ),
}
