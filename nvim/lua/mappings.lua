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
  
  for _, buf in ipairs(bufs) do
    if buf ~= current_buf then
      -- 检查缓冲区的 filetype 和 buftype
      local buf_ft = api.nvim_buf_get_option(buf, 'filetype')
      local buf_bt = api.nvim_buf_get_option(buf, 'buftype')
      
      -- 保护特殊的缓冲区类型
      local protected = {
        ['NvimTree'] = true,
        ['prompt'] = true,
        ['quickfix'] = true,
        ['help'] = true,
        ['dap-repl'] = true,
        ['terminal'] = true
      }
      
      -- 如果不是受保护的缓冲区类型，则关闭它
      if not protected[buf_ft] and not string.match(buf_ft, "^dapui_") then
        pcall(api.nvim_buf_delete, buf, {})
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
