require("ivan.remap")
require("ivan.lazy")
require("ivan.set")
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})

vim.o.background = "dark"
vim.cmd.colorscheme("tokyonight")
