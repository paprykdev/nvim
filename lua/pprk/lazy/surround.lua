return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = true,

  -- List key mappings
  -- keys = {
  --   { "ys", "<Plug>(surround-add)", mode = { "n", "x" }, desc = "Add surround" },
  --   { "ds", "<Plug>(surround-delete)", mode = { "n", "x" }, desc = "Delete surround" },
  --   { "cs", "<Plug>(surround-change)", mode = { "n", "x" }, desc = "Change surround" },
  --   { "yss", "<Plug>(surround-add-line)", mode = { "n", "x" }, desc = "Add line surround" },
  -- },
}
