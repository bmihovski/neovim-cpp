local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
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
    ["<leader>k"] = {
      "<cmd> DapTerminate <CR>",
      "Stop the debugger",
    },
    ["<leader>q"] = {
      "<cmd> lua require'dap'.clear_breakpoints() <CR>",
      "Clear breakpoints",
    },
    ["<leader>w"] = {
      function()
        local input = vim.fn.input "Conditional breakpoint: "
        require('dap').toggle_breakpoint(input)
      end,
      "Create conditional breakpoint",
    },
  }
}

return M
