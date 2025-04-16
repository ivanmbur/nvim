vim.opt.number = true
vim.opt.relativenumber = true

vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

vim.opt.undofile = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.incsearch = true

vim.opt.scrolloff = 10

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
