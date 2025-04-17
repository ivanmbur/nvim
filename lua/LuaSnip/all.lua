local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

return {

  -- Dynamic mathcal snippet: cA -> \mathcal{A}
  s({ trig = "c(%u)", regTrig = true, wordTrig = false }, {
    f(function(_, snip)
      return "\\mathcal{" .. snip.captures[1] .. "}"
    end),
  }),
  s("bigeq", {
    t({ "\\begin{equation}", "    " }),
    i(1),
    t({ "", "\\end{equation}" }),
  }),
  s(";a", t("\\alpha")),
  s(";b", t("\\beta")),
  s(";g", t("\\gamma")),
  s(";d", t("\\delta")),
  s(";e", t("\\epsilon")),
  s(";z", t("\\zeta")),
  s(";h", t("\\eta")),
  s(";t", t("\\theta")),
  s(";k", t("\\kappa")),
  s(";l", t("\\lambda")),
  s(";m", t("\\mu")),
  s(";n", t("\\nu")),
  s(";x", t("\\xi")),
  s(";p", t("\\pi")),
  s(";r", t("\\rho")),
  s(";s", t("\\sigma")),
  s(";f", t("\\phi")),
  s(";c", t("\\chi")),
  s(";o", t("\\omega")),
  s(";D", t("\\Delta")),
  s(";T", t("\\Theta")),
  s(";L", t("\\Lambda")),
  s(";X", t("\\Xi")),
  s(";P", t("\\Pi")),
  s(";S", t("\\Sigma")),
  s(";F", t("\\Phi")),
  s(";O", t("\\Omega")),
}
