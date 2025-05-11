local bo = vim.bo
local fn = vim.fn

---improves upon the default statusline components by having properly working icons
---@nodiscard
local function currentFile()
  local maxLen = 25

  local ext = fn.expand("%:e")
  local ft = bo.filetype
  local name = fn.expand("%:t")
  if ft == "octo" and name:find("^%d$") then
    name = "#" .. name
  elseif ft == "TelescopePrompt" then
    name = "Telescope"
  end

  local deviconsInstalled, devicons = pcall(require, "nvim-web-devicons")
  local ftOrExt = ext ~= "" and ext or ft
  if ftOrExt == "javascript" then ftOrExt = "js" end
  if ftOrExt == "typescript" then ftOrExt = "ts" end
  if ftOrExt == "markdown" then ftOrExt = "md" end
  if ftOrExt == "vimrc" then ftOrExt = "vim" end
  local icon = deviconsInstalled and devicons.get_icon(name, ftOrExt) or ""
  -- add sourcegraph icon for clarity
  if fn.expand("%"):find("^sg") then icon = "󰓁 " .. icon end

  -- truncate
  local nameNoExt = name:gsub("%.%w+$", "")
  if #nameNoExt > maxLen then name = nameNoExt:sub(1, maxLen) .. "…" .. ext end
  -- add modified icon
  if bo.modified then
   name = name .. " " .. "●" -- f044
   end

  if icon == "" then return name end
  return icon .. " " .. name
end

-- FIX Add missing buffer names for current file component
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lazy", "mason", "TelescopePrompt", "noice" },
  callback = function()
    local name = vim.fn.expand("<amatch>")
    name = name:sub(1, 1):upper() .. name:sub(2)     -- capitalize
    pcall(vim.api.nvim_buf_set_name, 0, name)
  end,
})

--- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/components/branch/git_branch.lua#L118
---@nodiscard
---@return boolean
local function isStandardBranch()
  -- checking via lualine API, to not call git outself
  local curBranch = require("lualine.components.branch.git_branch").get_branch()
  local notMainBranch = curBranch ~= "main" and curBranch ~= "master"
  local validFiletype = bo.filetype ~= "help"   -- vim help files are located in a git repo
  local notSpecialBuffer = bo.buftype == ""
  return notMainBranch and validFiletype and notSpecialBuffer
end


return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { statusline = { 'alpha', 'dashboard' } },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { {
          'branch',
          symbols = {

            unmerged = '✗', -- f057
            untracked = '★', -- f005
          }
        }, {
          currentFile,
          symbols = {
            modified = '✎', -- f044
          }
        } },
        lualine_c = {
          {
            'lsp_status',
            icon = '', -- f013
            symbols = {
              -- Standard unicode symbols to cycle through for LSP progress:
              spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
              -- Standard unicode symbol for when LSP is done:
              done = '✓',
              -- Delimiter inserted between LSP names:
              separator = ' ',
            },
            -- List of LSP names to ignore (e.g., `null-ls`):
            ignore_lsp = {},
          }
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'diff' },
        lualine_z = { 'location' }
      },
      -- inactive_sections = {
      --     lualine_a = {},
      --     lualine_b = {},
      --     lualine_c = { 'filename' },
      --     lualine_x = { 'location' },
      --     lualine_y = {},
      --     lualine_z = {},
      -- },
      tabline = {},
      extensions = {},
    })
  end,
}
