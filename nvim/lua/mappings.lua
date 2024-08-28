require "nvchad.mappings"
local utils = require("utils")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "Run or continue the debugger" })

-- Insert mode mappings
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })
map("i", "jk", "<ESC>")

-- Normal mode mappings
map("n", "<Esc>", ":noh<CR>", { desc = "Clear highlights" })

-- Switch between windows
map("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { desc = "Window left" })
map("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { desc = "Window right" })
map("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { desc = "Window down" })
map("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { desc = "Window up" })

-- Resize windows
map("n", "<S-Up>", ":resize -2<CR>")
map("n", "<S-Down>", ":resize +2<CR>")
map("n", "<S-Right>", ":vertical resize -2<CR>")
map("n", "<S-Left>", ":vertical resize +2<CR>")

-- Buffer management
map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Close buffer" })

map("n", "<leader>xo", function()
  require("nvchad.tabufline").closeOtherBufs()
end, { desc = "Close other buffers" })

-- Quickfix management
map("n", "<leader>qq", utils.toggle_quickfix, { desc = "Toggle the quickfix window" })
map("n", "<leader>qt", "<Cmd>TodoQuickFix<CR>", { desc = "Show the TodoQuickfix window" })

-- LSP actions
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action" })
