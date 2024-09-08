require "nvchad.mappings"
local utils = require("utils")

-- add yours here

local map = vim.keymap.set
local unmap = vim.keymap.del
local api = vim.api

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
map("n", "<S-Left>", ":vertical resize -2<CR>")
map("n", "<S-Right>", ":vertical resize +2<CR>")

-- Buffer management
unmap("n", "<leader>b")
map("n", "<leader>bo", function()
  local bufs = api.nvim_list_bufs()
  local current_buf = api.nvim_get_current_buf()
  -- 遍历每个缓冲区，获取并打印它的类型
  for _,i in ipairs(bufs) do
    if i~=current_buf then
      -- 检查缓冲区的 filetype
      local buf_ft = api.nvim_buf_get_option(i, 'filetype')
      local buf_bt = api.nvim_buf_get_option(i, 'buftype')
      -- 如果缓冲区的 filetype 不是 'NvimTree'，则删除它
      -- dap-ui 有一个特殊的 buftype 为 'prompt'，不应该删除
      if buf_ft ~= 'NvimTree' and buf_bt ~= 'prompt' then
        api.nvim_buf_delete(i, {})
      end
    end
  end
end, { desc = "Close other buffers" })

-- Quickfix management
map("n", "<leader>qq", utils.toggle_quickfix, { desc = "Toggle the quickfix window" })
map("n", "<leader>qt", "<Cmd>TodoQuickFix<CR>", { desc = "Show the TodoQuickfix window" })

-- Normal mode LSP mappings
-- LSP actions
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Action" })
map("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "LSP declaration" })
map("n", "gd", function() vim.lsp.buf.definition() end, { desc = "LSP definition" })
map("n", "K", function() vim.lsp.buf.hover() end, { desc = "LSP hover" })
map("n", "gi", function() vim.lsp.buf.implementation() end, { desc = "LSP implementation" })
map("n", "<leader>ls", function() vim.lsp.buf.signature_help() end, { desc = "LSP signature help" })
map("n", "<leader>D", function() vim.lsp.buf.type_definition() end, { desc = "LSP definition type" })
map("n", "<leader>ra", function() require("nvchad.renamer").open() end, { desc = "LSP rename" })
map("n", "gr", function() vim.lsp.buf.references() end, { desc = "LSP references" })
map("n", "<leader>lf", function() vim.diagnostic.open_float { border = "rounded" } end, { desc = "Floating diagnostic" })
map("n", "[d", function() vim.diagnostic.goto_prev { float = { border = "rounded" } } end, { desc = "Goto prev" })
map("n", "]d", function() vim.diagnostic.goto_next { float = { border = "rounded" } } end, { desc = "Goto next" })
map("n", "<leader>q", function() vim.diagnostic.setloclist() end, { desc = "Diagnostic setloclist" })
map("n", "<leader>wa", function() vim.lsp.buf.add_workspace_folder() end, { desc = "Add workspace folder" })
map("n", "<leader>wr", function() vim.lsp.buf.remove_workspace_folder() end, { desc = "Remove workspace folder" })
map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = "List workspace folders" })

map({"v", "x"}, "p", '"_dP', { noremap = true, silent = true })
map({"v", "x"}, "P", '"_dP', { noremap = true, silent = true })
