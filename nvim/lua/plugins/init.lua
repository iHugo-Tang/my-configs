local overrides = require("configs.overrides")
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "configs.dap-cfg"
    end
  },
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.formatter"
    end
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end
  },
  {
    'alexghergh/nvim-tmux-navigation',
    event = "VeryLazy",
    opts = {
      disable_when_zoomed = true,
    },
  },
  {
    'ruifm/gitlinker.nvim',
    event = "VeryLazy",
    opts = {
      print_url = true,
      mappings = "<leader>gh",
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = overrides.copilot,
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = function ()
      require('neogit').setup {}
      dofile(vim.g.base46_cache .. "git")
      -- dofile(vim.g.base46_cache .. "neogit")
    end
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
      })
    end,
  },
  {
    'uga-rosa/translate.nvim',
    event = "VeryLazy",
    config = function()
      require "configs.translate"
    end,
    opts = {},
  },
  -- obsdian
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      "BufReadPre " .. vim.fn.expand "~" .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/*.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/*.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "Documents",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/",
        },
      },
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      local opts = require("configs.chatgpt-cfg").options
      require("chatgpt").setup(opts)
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  -- ufo: code folding
  {
    'kevinhwang91/nvim-ufo',
    event = "VeryLazy",
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      local ufo = require("configs.ufo-cfg")
      require('ufo').setup(ufo.options)
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
    opts = {},
  },
  -- overrides
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup({
        notify=false
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = overrides.copilot_cmp,
  },
}
