local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

lspconfig.jdtls.setup {
  capabilities = capabilities,
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = "~/.sdkman/candidates/java/current",
            default = true,
          }
        }
      }
    }
  }
}

require('sonarlint').setup({
   server = {
      cmd = { 
         'sonarlint-language-server',
         -- Ensure that sonarlint-language-server uses stdio channel
         '-stdio',
         '-analyzers',
         -- paths to the analyzers you need, using those for python and java in this example
         vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
         vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
         vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
      },
      settings = {
        sonarlint = {
            pathToCompileCommands =  vim.fn.getcwd() .. '/compile_commands.json'
        }
     },
   },
   filetypes = {
      -- Tested and working
      'python',
      'cpp',
      -- Requires nvim-jdtls, otherwise an error message will be printed
      'java',
   }
})
