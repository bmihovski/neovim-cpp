local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities
capabilities.offsetEncoding = 'utf-8'

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
  filetypes={ "c", "cpp","hpp","h", "objc", "objcpp", "cuda", "proto" },
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  root_dir=require('lspconfig').util.root_pattern(
          '.clangd',
          '.clang-tidy',
          '.clang-format',
          'compile_commands.json',
          'compile_flags.txt',
          'configure.ac',
          '.git'
        )
}

local servers = {
  "pyright",
  "ruff_lsp",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    filetypes={ "python","py" },
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {"python"},
  })
end
