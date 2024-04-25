vim.opt.guicursor = ""
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- use minus as <Leader> key in shortcuts
vim.g.mapleader = '-'

---use Backspace as an alias for my Space shortcut prefix so that my stuff can
-- coexist with LazyVim (which also has Space shortcuts) as I transition over.


local keymap = vim.api.nvim_set_keymap
keymap("n", "<bs>", "<space>", { noremap = true, silent = true })
keymap("n", "<C-f>", "<cmd> !tmux neww tmux-sessionizer <CR>", { noremap = true, silent = true })
 -- cmake run
keymap("n", "<leader>d", "<cmd> CMakeDebug <CR>", { noremap = true, silent = true })
keymap("n", "<leader>m", "<cmd> CMakeRun <CR>", { noremap = true, silent = true })
keymap("n", "<leader>s", "<cmd> CMakeCloseExecutor <CR><cmd> CMakeCloseRunner <CR>", { noremap = true, silent = true })
-- copilot chat
keymap("n", "<leader>t", "<cmd> CopilotChatToggle <CR>", { noremap = true, silent = true })
-- telescope
keymap("n", "<leader>;", "<cmd> Telescope git_files <CR>", { noremap = true, silent = true })
keymap("n", "<leader>.", "<cmd> lua require('telescope').extensions.recent_files.pick() <CR>", { noremap = true, silent = true })
keymap("n", "<leader>lw", "<cmd> Telescope lazygit <CR>", { noremap = true, silent = true })
keymap("n", "<leader>8", "<cmd> Telescope live_grep <CR>", { noremap = true, silent = true })
keymap("n", "<leader>7", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { noremap = true, silent = true })
--trouble
keymap("n", "<leader>xx", "<cmd> lua require('trouble').toggle() <CR>", { noremap = true, silent = true })
-- java test
keymap("n", "<leader>ht", "<cmd> JavaTestRunCurrentMethod <CR>", { noremap = true, silent = true })
keymap("n", "<leader>ld", "<cmd> JavaTestDebugCurrentMethod <CR>", { noremap = true, silent = true })
keymap("n", "<leader>rm", "<cmd> JavaTestViewLastReport <CR>", { noremap = true, silent = true })
-- dap ui icons
vim.fn.sign_define('DapBreakpoint', { text='🟤', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='▶️', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
-- merge conflict
vim.api.nvim_create_autocmd('User', {
  pattern = 'GitConflictDetected',
  callback = function()
    vim.notify('Conflict detected in '..vim.fn.expand('<afile>'))
    vim.keymap.set('n', 'cww', function()
      engage.conflict_buster()
      create_buffer_local_mappings()
    end)
  end
})