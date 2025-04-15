return {
  {
    "neovim/nvim-lspconfig",
    config = function()
require('lspconfig').pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false }, -- disable if using black or ruff
        mccabe = { enabled = false },
        pyflakes = { enabled = false },
        black = { enabled = true },
        yapf = { enabled = false },
        rope_completion = { enabled = true },
      }
    }
  }
}
    end
  }
}


