require("pprk.set")
require("pprk.remap")
require("pprk.lazy_init")

ColorMyPencils()

local vim = vim

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not

local augroup = vim.api.nvim_create_augroup
local ThePprkGroup = augroup('ThePprk', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = ThePprkGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})


vim.diagnostic.config({
    float = {
        border = "rounded",
    },
})

-- local function hover_with_window()
--     local width = math.floor(vim.o.columns)
--     local height = math.floor(vim.o.lines)
--
--     vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
--         border = 'rounded',
--         max_width = width,
--         max_height = height,
--     })
--
--     vim.lsp.buf.hover()
-- end

autocmd('LspAttach', {
    group = ThePprkGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts, { desc = "Go to definition" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts, { desc = "Show hover" })
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts, { desc = "Workspace symbol" })
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts, { desc = "Show diagnostics" })
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts, { desc = "Code action" })
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts, { desc = "References" })
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts, { desc = "Rename" })
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts, { desc = "Signature help" })
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts, { desc = "Next diagnostic" })
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts, { desc = "Previous diagnostic" })
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
