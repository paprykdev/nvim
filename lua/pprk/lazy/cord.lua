return {
    'vyfor/cord.nvim',
    ---@type CordConfig
    opts = {
        editor = {
            tooltip = "i use vim btw",
        },
        display = {
            theme = 'minecraft',
        },
        idle = {
            timeout = 60000,
        },
        buttons = {
            {
                label = 'Check out the repo',
                url = function(opts) return opts.repo_url end,
            },
        },
        assets = {
            ['.rs'] = {
                name = 'Rust', -- Asset name
                tooltip = 'Rustling', -- Hover text
            },
            ['.go'] = {
                name = 'Go', -- Asset name
                tooltip = 'Googling', -- Hover text
            },
            netrw = {
                name = 'Netrw', -- Asset name
                tooltip = 'Fuzzy finding..', -- Hover text
                type = 'file_browser' -- Set asset type
            }
        }
    }
}
