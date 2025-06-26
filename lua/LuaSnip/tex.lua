local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node
local d = ls.dynamic_node  -- Add this
local sn = ls.snippet_node -- Add this

return {

  -- Dynamic mathcal snippet: cA -> \mathcal{A}
  s({ trig = "c(%u)", regTrig = true, wordTrig = false, snippetType = "autosnippet"}, {
    f(function(_, snip)
      return "\\mathcal{" .. snip.captures[1] .. "}"
    end),
  }),
  s({ trig = "b(%u)", regTrig = true, wordTrig = false, snippetType = "autosnippet"}, {
    f(function(_, snip)
      return "\\mathbb{" .. snip.captures[1] .. "}"
    end),
  }),
  s("bigeq", {
    t({ "\\begin{equation}", "    " }),
    i(1),
    t({ "", "\\end{equation}" }),
  }),
  s({trig = ";a", snippetType = "autosnippet"}, t("\\alpha")),
  s({trig = ";b", snippetType = "autosnippet"}, t("\\beta")),
  s({trig = ";g", snippetType = "autosnippet"}, t("\\gamma")),
  s({trig = ";d", snippetType = "autosnippet"}, t("\\delta")),
  s({trig = ";e", snippetType = "autosnippet"}, t("\\epsilon")),
  s({trig = ";z", snippetType = "autosnippet"}, t("\\zeta")),
  s({trig = ";h", snippetType = "autosnippet"}, t("\\eta")),
  s({trig = ";t", snippetType = "autosnippet"}, t("\\theta")),
  s({trig = ";k", snippetType = "autosnippet"}, t("\\kappa")),
  s({trig = ";l", snippetType = "autosnippet"}, t("\\lambda")),
  s({trig = ";m", snippetType = "autosnippet"}, t("\\mu")),
  s({trig = ";n", snippetType = "autosnippet"}, t("\\nu")),
  s({trig = ";x", snippetType = "autosnippet"}, t("\\xi")),
  s({trig = ";p", snippetType = "autosnippet"}, t("\\pi")),
  s({trig = ";r", snippetType = "autosnippet"}, t("\\rho")),
  s({trig = ";s", snippetType = "autosnippet"}, t("\\sigma")),
  s({trig = ";f", snippetType = "autosnippet"}, t("\\phi")),
  s({trig = ";c", snippetType = "autosnippet"}, t("\\chi")),
  s({trig = ";o", snippetType = "autosnippet"}, t("\\omega")),
  s({trig = ";w", snippetType = "autosnippet"}, t("\\psi")),
  s({trig = ";D", snippetType = "autosnippet"}, t("\\Delta")),
  s({trig = ";T", snippetType = "autosnippet"}, t("\\Theta")),
  s({trig = ";L", snippetType = "autosnippet"}, t("\\Lambda")),
  s({trig = ";X", snippetType = "autosnippet"}, t("\\Xi")),
  s({trig = ";P", snippetType = "autosnippet"}, t("\\Pi")),
  s({trig = ";S", snippetType = "autosnippet"}, t("\\Sigma")),
  s({trig = ";F", snippetType = "autosnippet"}, t("\\Phi")),
  s({trig = ";O", snippetType = "autosnippet"}, t("\\Omega")),
  s({ trig = "([%a%d]+)//", regTrig = true, wordTrig = false, snippetType = "autosnippet"}, {
    t("\\frac{"),
    d(1, function(_, snip)
      return sn(nil, { i(1, snip.captures[1]) })
    end),
    t("}{"),
    i(2),
    t("}"),
  }),

  -- Basic fraction snippet (e.g., type "//" to get \frac{}{})
  s("//", {
    t("\\frac{"),
    i(1),
    t("}{"),
    i(2),
    t("}"),
  }),
}
