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
vim.cmd([[silent! runtime plugin/rplugin.vim]])

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
keymap("n", "<leader>z", "<cmd> lua require('telescope').extensions.zoxide.list({picker_opts})<CR>", { noremap = true, silent = true })
-- outline symbols
keymap("n", "<F5>", "<Cmd>SymbolsOutline<CR>", { noremap = true, silent = true })
--trouble
keymap("n", "<leader>xx", "<cmd> lua require('trouble').toggle() <CR>", { noremap = true, silent = true })
-- java test
keymap("n", "<A-o>", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { noremap = true, silent = true })
keymap("n", "<leader>jv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { noremap = true, silent = true })
keymap("x", "<leader>jv", "<Cmd>lua require('jdtls').extract_variable(true)<CR>", { noremap = true, silent = true })
keymap("n", "<leader>jw", "<Cmd>lua require('jdtls').extract_constant()<CR>", { noremap = true, silent = true })
keymap("x", "<leader>jw", "<Cmd>lua require('jdtls').extract_constant(true)<CR>", { noremap = true, silent = true })
keymap("n", "<leader>jt", "<Cmd>lua require('jdtls').test_nearest_method()<CR>", { noremap = true, silent = true })
keymap("n", "<leader>jd", "<Cmd>lua require'jdtls'.test_class()<CR>", { noremap = true, silent = true })
keymap("n", "<leader>ju", "<Cmd>JdtUpdateConfig<CR>", { noremap = true, silent = true })

keymap("v", "<leader>jv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", { noremap = true, silent = true })
keymap("v", "<leader>jw", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", { noremap = true, silent = true })
keymap("v", "<leader>jm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { noremap = true, silent = true })
keymap("x", "<leader>jm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", { noremap = true, silent = true })
keymap("n", "<leader>jl", "<Cmd>lua function() vim.lsp.buf.incoming_calls() end<CR>", { noremap = true, silent = true })
keymap("n", "<leader>jp", "<Cmd>lua require('jdtls').super_implementation<CR>", { noremap = true, silent = true })
keymap("n", "<leader>js", "<Cmd>lua require('jdtls').jshell()<CR>", { noremap = true, silent = true })
-- keymap("n", "<leader>ht", "<cmd> JavaTestRunCurrentMethod <CR>", { noremap = true, silent = true })
-- keymap("n", "<leader>ld", "<cmd> JavaTestDebugCurrentMethod <CR>", { noremap = true, silent = true })
-- keymap("n", "<leader>rm", "<cmd> JavaTestViewLastReport <CR>", { noremap = true, silent = true })
keymap("n", "<F6>", "<cmd> MarkdownPreviewToggle<CR>", { noremap = true, silent = true })
-- python
keymap("n", "<leader>vl", "<cmd>VenvSelect<CR>", { noremap = true, silent = true })
keymap("n", "<leader>vh", "<cmd>VenvSelectCached<CR>", { noremap = true, silent = true })
keymap("n", "<leader>kw", "<cmd>lua require('dap-python').test_method()<CR>", { noremap = true, silent = true })
keymap("n", "<leader>kf", "<cmd>lua require('dap-python').test_class()<CR>", { noremap = true, silent = true })
keymap("n", "<leader>ks", "<cmd>lua require('dap-python').debug_selection()<CR>", { noremap = true, silent = true })
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