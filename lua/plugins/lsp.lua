return {
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
                ensure_installed = { "pyright", "lua_ls", "clangd", "julials", "texlab", "html" },
                automatic_installation = true,
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config["pyright"] = {
                capabilities = capabilities,
                settings = {

                    python = {
                        analysis = {
                            extraPaths = { "modules" }, -- <--- your extra folders
                        },
                    },
                }
            }
                -- require("mason-lspconfig").setup_handlers {
                --     function(server_name)
                --         local opts = {
                --             capabilities = capabilities,
                --         }
                --
                --         if server_name == "lua_ls" then
                --             opts.settings = {
                --                 Lua = {
                --                     diagnostics = {
                --                         globals = { "vim" },
                --                     },
                --                     workspace = {
                --                         library = vim.api.nvim_get_runtime_file("", true),
                --                         checkThirdParty = false,
                --                     },
                --                 },
                --             }
                --         end
                --
                --         if server_name == "pyright" then
                --             opts.settings = {
                --                 python = {
                --                     analysis = {
                --                         extraPaths = { "modules" }, -- <--- your extra folders
                --                     },
                --                 },
                --             }
                --         end
                --
                --         require("lspconfig")[server_name].setup(opts)
                --     end,
                -- }

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
