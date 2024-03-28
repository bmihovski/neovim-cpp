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
    }
  }
}

return M
