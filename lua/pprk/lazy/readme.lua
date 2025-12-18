return {
  -- Markdown syntax and folding
  {
    "preservim/vim-markdown",
    ft = "markdown",
    config = function()
      vim.g.vim_markdown_folding_disabled = 0
      vim.g.vim_markdown_folding_level = 2
    end,
  },

  -- Smooth writing experience
{
  "preservim/vim-pencil",
  ft = { "markdown", "text" },
  config = function()
    vim.cmd("PencilSoft")
  end,
},
  -- Optional preview in browser
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
    end,
  },
}
