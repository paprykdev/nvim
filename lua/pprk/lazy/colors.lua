function ColorMyPencils(color)
    color = color or "catppuccin-macchiato"
    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {

    {
        "catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato", -- latte, frappe, macchiato, mocha
                background = {         -- :h background
                    light = "latte",
                    dark = "macchiato",
                },
                transparent_background = false,
                term_colors = true,
                styles = {
                    comments = { "italic" },
                    conditionals = {},
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    unused_variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                    miscs = {},
                },

                color_overrides = {
                    macchiato = {
                        base = "#101C2E",
                        text = "#B2CAD3",
                        -- mauve = "#6ABED7",
                        overlay2 = "#7D8DA4",
                        peach = "#D7976D",
                        green = "#90C366",
                        sky = "#B5D0D9",
                        lavender = "#AEC6D0",
                        yellow = "#56B0BE"
                    },
                },

                highlight_overrides = {
                    all = function(_)
                        return {
                            -- ["@variable"] = { fg = "#CC2782" },
                            ["@comment"] = { fg = "#4C5C73", italic = true },
                            ["@keyword.function"] = { fg = "#6ABED7", italic = true },
                            LineNr = { fg = "#57737F" },
                            CursorLineNr = { fg = "#DC976C" },
                            CursorLine = { bg = "#003647" },
                        }
                    end
                },
            })
        end,
    },



    {
        "erikbackman/brightburn.vim",
    },

    {
        "olimorris/onedarkpro.nvim",
        config = function()
            require("onedarkpro").setup({
                colors = {
                    cursorline = "#2a2a2a",
                },
                options = {
                    cursorline = true,
                    -- transparency = true,
                    -- lualine_transparency = true,
                    terminal_colors = true,
                },
            })
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = false,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "",  -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = true,
            })
        end,
    },
    {
        "folke/tokyonight.nvim",
        config = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "moon",         -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = false,    -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = true },
                    keywords = { italic = true },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark",   -- style for floating windows
                },
            })
        end
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                styles = {
                    italic = true,
                    bold = true,
                    underline = true,
                    undercurl = true,
                    strikethrough = false,
                },
            })
        end
    },


}
