return {
    {"barreiroleo/ltex-extra.nvim"},
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-nvim-lsp-signature-help"
        },

        on_attach = function(_, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
        end,

        config = function()

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config["wolfram_lsp"] = {
                capabilities = capabilities,
                filetypes = { "wolfram", "mma", "wl", "wls" },
                -- The command to start the kernel in LSP mode
                cmd = {
                    "wolfram", "kernel",
                    "-noinit", "-noprompt", "-nopaclet",
                    "-noicon", "-nostartuppaclets",
                    "-run", 'Needs["LSPServer`"];LSPServer`StartServer[]'
                },
                root_dir = lspconfig.util.root_pattern("project.wl", ".git", "script.wls"),
            }

            vim.lsp.enable('pyright')
            vim.lsp.enable('julials')
            vim.lsp.config["ltex_plus"] = {
                on_attach = function()
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
                    require("ltex_extra").setup()
                end,
                settings = {
                    ltex = {
                        checkFrequency = 'save',
                        enabled = { 'markdown', 'plaintex', 'tex', 'latex' },
                        language = 'en-US',       -- default language
                    },
                },
            }
            vim.lsp.enable('ltex_plus')

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- nvim-cmp setup
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "copilot" },
                    { name = "nvim_lsp_signature_help" }
                })
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                        { name = "cmdline" },
                    }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })
        end,
    },
}
