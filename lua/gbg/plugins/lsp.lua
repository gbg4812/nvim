return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",

        -- cmp and its sources
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-emoji",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    },

    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require('fidget').setup {};
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                "lua_ls",
                "clangd",
                "pyright",
                "bashls",
                "ruff_lsp",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                -- making vim a global variable
                ['lua_ls'] = function()
                    require("lspconfig").lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = { globals = { "vim" } },
                                workspace = {
                                    -- Make the server aware of Neovim runtime files
                                    library = vim.api.nvim_get_runtime_file('', true),
                                },
                            }
                        },
                        capabilities = capabilities
                    })
                end,
                ['clangd'] = function()
                    require("lspconfig").clangd.setup {
                        capabilities = capabilities,
                        cmd = { "clangd", "-header-insertion=never" },
                    }
                end
            }
        })
        require("lspconfig").glsl_analyzer.setup {
            capabilities = capabilities
        }

        local cmp = require('cmp')
        local select_opts = { behavior = cmp.SelectBehavior.Select }

        cmp.setup {
            formatting = {
                fields = { 'menu', 'abbr', 'kind' },
                format = function(entry, item)
                    local menu_icon = {
                        nvim_lsp = 'λ',
                        luasnip = '⋗',
                        buffer = 'Ω',
                        path = '🖫',
                    }

                    item.menu = menu_icon[entry.source.name]
                    return item
                end,
            },

            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },

            sources = {
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'emoji' },
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
                ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            })
        }

        vim.diagnostic.config({
            virtual_text = true,
            update_on_insert = true,
        })
    end,
}
