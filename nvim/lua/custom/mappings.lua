local utils = require("custom.utils")

local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dc"] = {
      "<cmd> DapContinue <CR>",
      "Run or continue the debugger"
    }
  },
}

M.general = {
  i = {
    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
    ["jk"] = { "<ESC>" },
  },

  n = {
    ["<Esc>"] = { ":noh <CR>", "Clear highlights" },

    -- switch between windows
    ["<C-h>"] = { "<Cmd>NvimTmuxNavigateLeft<CR>", "Window left" },
    ["<C-l>"] = { "<Cmd>NvimTmuxNavigateRight<CR>", "Window right" },
    ["<C-j>"] = { "<Cmd>NvimTmuxNavigateDown<CR>", "Window down" },
    ["<C-k>"] = { "<Cmd>NvimTmuxNavigateUp<CR>", "Window up" },

    -- resize
    ["<S-Up>"] = { ":resize -2<CR>" },
    ["<S-Down>"] = { ":resize +2<CR>" },
    ["<S-Left>"] = { ":vertical resize -2<CR>" },
    ["<S-Right>"] = { ":vertical resize +2<CR>" },

    -- buffer
    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
    -- close buffer + hide terminal buffer
    ["<leader>xo"] = {
      function()
        require("nvchad.tabufline").closeOtherBufs()
      end,
      "Close other buffers",
    },

    -- quickfix
    ["<leader>qq"] = { utils.toggle_quickfix, "Toggle the quickfix window." },
    ["<leader>qt"] = { "<Cmd>TodoQuickFix<CR>", "Show the TodoQuickfix window." },

    -- lsp
    ["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" }
  },
}

return M
