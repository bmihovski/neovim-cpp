local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>dd"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
      opts = { }
    },
    ["<leader>o"] = {
      "<cmd> DapStepOut <CR>",
      "Step out the debugger",
      opts = { }
    },
    ["<F7>"] = {
      "<cmd> DapStepInto <CR>",
      "Step into the debugger",
    },
    ["<F8>"] = {
      "<cmd> DapStepOver <CR>",
      "Step over the debugger",
    },
    ["<F9>"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    ["<leader>f"] = {
      "<cmd> DapTerminate <CR>",
      "Stop the debugger",
    },
    ["<leader>r"] = {
      "<cmd> lua require'dap'.clear_breakpoints() <CR>",
      "Clear breakpoints",
    },
    ["<leader>o"] = {
      function() require"dap.ui.widgets".hover() end,
      "Variables",
    },
    ["<leader>w"] = {
      "<cmd> lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) <CR>",
      "Create conditional breakpoint",
    },
    ["<leader>l"] = {
      "<cmd> lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) <CR>",
      "Create log point breakpoint",
    },
  }
}

return M
