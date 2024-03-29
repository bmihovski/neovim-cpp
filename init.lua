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