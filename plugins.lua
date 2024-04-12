local plugins = {
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    'nvim-java/nvim-java',
    event = "VeryLazy",
    dependencies = {
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'MunifTanjim/nui.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      {
        'williamboman/mason.nvim',
        opts = {
          registries = {
            'github:nvim-java/mason-registry',
            'github:mason-org/mason-registry',
          },
        },
      },
      {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        handlers = {
          ["jdtls"] = function()
            require("java").setup()
          end,
        },
      },
    },
    },
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter", "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
    opts = {
      handlers = {}
    }
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter", "mfussenegger/nvim-dap" },
    opts = {
      handlers = {}
    }
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies =  {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim"
    },
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
    config = function()
        require("telescope").load_extension("lazygit")
    end,
},
  {
    "https://gitlab.com/yorickpeterse/nvim-pqf.git",
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
    config = function()
      require("pqf").setup()
    end
  },
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
    config = function()
      require("git-conflict").setup()
    end
  },
  {
    "smartpde/telescope-recent-files",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      handlers = {}
    },
    config = function()
      require("telescope").load_extension("recent_files")
    end
  },
  {
    "Civitasv/cmake-tools.nvim",
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
  },
  { 
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      handlers = {}
    }
  },
  {
    "folke/neoconf.nvim",
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
      }
  },
  {
    "booperlv/nvim-gomove",
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
  },
  {
    "AndreM222/copilot-lualine",
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
    config = function ()
      require("lualine").setup({
    sections = {
      lualine_x = {'copilot' ,'encoding', 'fileformat', 'filetype'},
    },
    })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
      require("cmp").setup({
        sources = {
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
        })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = false, -- Disable debugging
    },
    build = function()
      vim.cmd("UpdateRemotePlugins") -- You need to restart to make it works
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {}
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("neoconf").setup()
      require('java').setup()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "codelldb",
        "cmakelint",
        "cpptools",
        "jdtls",
        "google-java-format",
        "java-debug-adapter"
      },
    }
  }
}
return plugins
