return {
    {
        "barreiroleo/ltex_extra.nvim",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
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
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "lua_ls", "clangd", "julials", "texlab", "html", "lemminx", "ltex_plus"},
                automatic_installation = true,
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config["pyright"] = {
                capabilities = capabilities,
                settings = {

                    python = {
                        analysis = {
                        },
                    },
                }
            }

            vim.lsp.config["julials"] = {
                capabilities = capabilities,
                on_new_config = function(new_config, _)
                    local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
                    if require('lspconfig').util.path.is_file(julia) then
                        new_config.cmd[1] = julia
                    end
                end
            }

            vim.lsp.config["ltex_plus"] = {
                on_attach = function()
                    -- setup ltex_extra during on_attach
                    require("ltex_extra").setup({
                        load_langs = { "en-US" },
                        -- save to .ltex dir
                        path = ".ltex",
                    })
                end,
                settings = {
                    ltex = {
                        checkFrequency = 'save',
                        enabled = { 'markdown', 'plaintex', 'tex', 'latex' },
                        language = 'en-US',       -- default language
                    },
                },
            }

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
