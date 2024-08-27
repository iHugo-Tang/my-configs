local g = vim.g
local opt = vim.opt
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

g.mapleader = ","
g.maplocalleader = ","

-- Resize with arrows
keymap("n", "<S-Up>", ":resize +2<CR>", opts)
keymap("n", "<S-Down>", ":resize -2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize -2<CR>", opts)

-- markdown options
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

-- im-select
require("custom/im-select")
