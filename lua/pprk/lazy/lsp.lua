local vim = vim

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        { "hrsh7th/nvim-cmp", event = "InsertEnter" },
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "onsails/lspkind.nvim",
    },

    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                -- lua = { "stylua" },
                -- zig = { "zigfmt" },
                -- go = { "goimports" },
                -- rust = { "rustfmt" },
                -- cpp = { "clangformat" },
                -- c = { "clangformat" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                json = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier", "ts_ls" },
                vue = { "prettier" },
                markdown = { "prettier" },
                yaml = { "prettier" },
            }
        })

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local lspkind = require("lspkind")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "gopls",
                "volar",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,
                ["rust_analyzer"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.rust_analyzer.setup {
                        capabilities = capabilities,
                        settings = {
                            ["rust-analyzer"] = {
                                diagnostics = {
                                    enable = false,
                                },
                            }
                        }
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        -- local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-h>"] = cmp.mapping.scroll_docs(-4),    -- scroll up in documentation
                ["<C-l>"] = cmp.mapping.scroll_docs(4),     -- scroll down in documentation
                ["<C-Space>"] = cmp.mapping.complete(),     -- show completion suggestions
                ["<Esc>"] = cmp.mapping.abort(),            -- close completion window
                ["<C-y>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping.confirm({ select = true })
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- snippets
                { name = "buffer" },  -- text within current buffer
                { name = "path" },    -- file system paths
            }),
            window = {
                completion = {
                    -- border = {
                    --     { "󱐋", "WarningMsg" },
                    --     { "─", "Comment" },
                    --     { "╮", "Comment" },
                    --     { "│", "Comment" },
                    --     { "╯", "Comment" },
                    --     { "─", "Comment" },
                    --     { "╰", "Comment" },
                    --     { "│", "Comment" },
                    -- },
                    scrollbar = false,
                    winblend = 0,
                },
                documentation = {
                    -- border = {
                    --     { "󰙎", "DiagnosticHint" },
                    --     { "─", "Comment" },
                    --     { "╮", "Comment" },
                    --     { "│", "Comment" },
                    --     { "╯", "Comment" },
                    --     { "─", "Comment" },
                    --     { "╰", "Comment" },
                    --     { "│", "Comment" },
                    -- },
                    scrollbar = false,
                    winblend = 0,
                },
            },
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}

