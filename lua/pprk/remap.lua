local is_wrapped = false
local copilot_enabled = false
local vim = vim
local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.copilot_enabled = copilot_enabled

local function toggle_wrap()
    is_wrapped = not is_wrapped
    vim.opt.wrap = is_wrapped
    if is_wrapped then
        vim.notify("Line wrapping enabled")
    else
        vim.notify("Line wrapping disabled")
    end
end

local function toggle_copilot()
    copilot_enabled = not copilot_enabled
    vim.g.copilot_enabled = copilot_enabled
    if copilot_enabled then
        vim.notify("Copilot enabled")
    else
        vim.notify("Copilot disabled")
    end
end

local function check_copilot()
    vim.notify("Copilot is " .. (copilot_enabled and "enabled" or "disabled"))
end


keymap.set("n", "<leader>pv", vim.cmd.Ex, {desc = "Dora de explora"})

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor in place" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })

-- Markdown
-- keymap.set("n", "<leader>1", "msI# <Esc>`s2l", { desc = "H2 heading" })
-- keymap.set("n", "<leader>2", "msI## <Esc>`s3l", { desc = "H2 heading" })
-- keymap.set("n", "<leader>3", "msI### <Esc>`s4l", { desc = "H3 heading" })
-- keymap.set("n", "<leader>pm", ":MarkdownPreviewToggle<CR>", { desc = "Preview Markdown" })

-- Toggling

keymap.set("n", "<leader>tw", toggle_wrap, { desc = "Toggle line wrapping" })
keymap.set("n", "<leader>tai", toggle_copilot, { desc = "Toggle Copilot" })
keymap.set("n", "<leader>th", "<cmd>CloakToggle<CR>", { desc = "Toggle Cloak" })

-- Status

keymap.set("n", "<leader>tas", check_copilot, { desc = "Check Copilot status" })

keymap.set("n", "n", "nzzzv", { desc = "Search next and center cursor" })
keymap.set("n", "N", "Nzzzv", { desc = "Search previous and center cursor" })
keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end, { desc = "Start Vim With Me" })
keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end, { desc = "Stop Vim With Me" })

-- greatest remap ever
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })

-- next greatest remap ever : asbjornHaland
keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank whole line to system clipboard" })

keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete without overwriting register" })

-- This is going to get me cancelled
keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })

keymap.set("n", "Q", "<nop>", { desc = "Disable Q" })
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open tmux sessionizer" })
keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format current buffer" })

keymap.set("n", "<leader><C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
keymap.set("n", "<leader><C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location in quickfix list" })
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location in quickfix list" })

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor" })
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }, { desc = "Make file executable" })

keymap.set(
    "n",
    "<leader>se",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
    , { desc = "Insert error handling" }
)

keymap.set(
    "n",
    "<leader>sa",
    "oassert.NoError(err, \"\")<Esc>F\";a"
    , { desc = "Insert assert error handling" })

keymap.set(
    "n",
    "<leader>sf",
    "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj"
    , { desc = "Insert fatal error handling" }
)

keymap.set(
    "n",
    "<leader>sl",
    "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
    , { desc = "Insert log error handling" }
)

keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/pprk/lazy_init.lua<CR>", { desc = "Edit lazy_init.lua" });
keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" });

keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = "Source current file" })

keymap.set("n", "<leader>q", ":w !gcc % -o %:r && konsole --hold -e ./%:r<CR>", { desc = "Compile and run" })

-- Compile and run keymaps
-- F3: C++
-- F4: Rust
-- F5: Go
-- F6: Java
-- F7: Python
-- F8: C
-- F9: Node

keymap.set("n", "<F3>", ":w<CR>:!g++ % -o %:r && konsole --hold -e ./%:r<CR>", { desc = "Compile and run C++" })
keymap.set("n", "<F4>", ":w<CR>:!konsole --hold -e cargo run<CR>", { desc = "Compile and run Rust" })
keymap.set("n", "<F5>", ":w<CR>:!go run %<CR>", { desc = "Compile and run Go" })
keymap.set("n", "<F6>", ":w<CR>:!javac % && konsole --hold -e java %:r<CR>", { desc = "Compile and run Java" })
keymap.set("n", "<F7>", ":w<CR>:!python3 %<CR>", { desc = "Compile and run Python" })
keymap.set("n", "<F8>", ":w<CR>:!gcc % -o %:r && konsole --hold -e ./%:r<CR>", { desc = "Compile and run C" })
keymap.set("n", "<F9>", ":w<CR>:!node %<CR>", { desc = "Compile and run Node.js" })
