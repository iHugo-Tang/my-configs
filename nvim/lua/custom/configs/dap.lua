require("dapui").setup()

local dap = require("dap")

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/code/ts/vscode-node-debug2/out/src/nodeDebug.js'},
}

local js_based_languages = { "typescript", "javascript", "typescriptreact" }
for _, language in ipairs(js_based_languages) do
    dap.configurations[language] = {
    {
      name = 'Debug NestJS',
      type = 'node2',
      request = 'launch',
      preLaunchTask = 'npm run start:debug',
      program = '${file}',
      outFiles = {
        '${workspaceFolder}/dist/src/*.js',
      },
      cwd = "${workspaceFolder}",
      -- cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Launch',
      type = 'node2',
      request = 'launch',
      preLaunchTask = 'npm run build',
      program = '${file}',
      outFiles = {
        '${workspaceFolder}/dist/src/*.js',
      },
      cwd = "${workspaceFolder}",
      -- cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
      name = 'Attach to process',
      type = 'node2',
      request = 'attach',
      processId = require'dap.utils'.pick_process,
    },
  }
end

local dap_breakpoint = {
  error = {
    text = "🟥",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  rejected = {
    text = "",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = "⭐️",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
  },
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

-- Set keymaps to control the debugger
vim.keymap.set('n', '<F6>', require 'dap'.continue)
vim.keymap.set('n', '<F7>', require 'dap'.step_over)
vim.keymap.set('n', '<F8>', require 'dap'.step_into)
vim.keymap.set('n', '<F9>', require 'dap'.step_out)
vim.keymap.set('n', '<F10>', ":lua require('dap').terminate()<CR>:lua require('dapui').toggle()<CR>")
