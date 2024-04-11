vim.opt.guicursor = ""
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.scrolloff = 8
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.smartindent = true
local keymap = vim.api.nvim_set_keymap
-- cmake run
keymap("n", "<leader>d", "<cmd> CMakeDebug <CR>", { noremap = true, silent = true })
keymap("n", "<leader>f", "<cmd> CMakeRun <CR>", { noremap = true, silent = true })
keymap("n", "<leader>s", "<cmd> CMakeCloseExecutor <CR><cmd> CMakeCloseRunner <CR>", { noremap = true, silent = true })
-- copilot chat
keymap("n", "<leader>a", "<cmd> CopilotChatToggle <CR>", { noremap = true, silent = true })
-- telescope
keymap("n", "<leader>g", "<cmd> Telescope git_files <CR>", { noremap = true, silent = true })
keymap("n", "<leader><leader>", "<cmd> lua require('telescope').extensions.recent_files.pick() <CR>", { noremap = true, silent = true })
--trouble
keymap("n", "<leader>xx", "<cmd> lua require('trouble').toggle() <CR>", { noremap = true, silent = true })
-- dap ui icons
vim.fn.sign_define('DapBreakpoint', { text='🟤', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='▶️', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })