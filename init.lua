vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.smartindent = true
local keymap = vim.api.nvim_set_keymap
-- cmake run
keymap("n", "<leader>d", "<cmd> CMakeDebug <CR>", { noremap = true, silent = true })
keymap("n", "<leader>f", "<cmd> CMakeRun <CR>", { noremap = true, silent = true })
keymap("n", "<leader>s", "<cmd> CMakeCloseRunner <CR>", { noremap = true, silent = true })
