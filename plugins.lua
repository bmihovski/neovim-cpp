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
    "gen740/SmoothCursor.nvim",
    lazy = false,
    config = function()
        require('smoothcursor').setup({
            autostart = true,
            cursor = "", -- cursor shape (need nerd font)
            texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
            linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
            type = "default", -- define cursor movement calculate function, "default" or "exp" (exponential).
            fancy = {
                enable = false, -- enable fancy mode
                head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
                body = {
                    { cursor = "", texthl = "SmoothCursorRed" },
                    { cursor = "", texthl = "SmoothCursorOrange" },
                    { cursor = "●", texthl = "SmoothCursorYellow" },
                    { cursor = "●", texthl = "SmoothCursorGreen" },
                    { cursor = "•", texthl = "SmoothCursorAqua" },
                    { cursor = ".", texthl = "SmoothCursorBlue" },
                    { cursor = ".", texthl = "SmoothCursorPurple" },
                },
                tail = { cursor = nil, texthl = "SmoothCursor" }
            },
            flyin_effect = nil, -- "bottom" or "top"
            speed = 25, -- max is 100 to stick to your current position
            intervals = 35, -- tick interval
            priority = 10, -- set marker priority
            timeout = 3000, -- timout for animation
            threshold = 3, -- animate if threshold lines jump
            disable_float_win = false, -- disable on float window
            enabled_filetypes = nil, -- example: { "lua", "vim" }
            disabled_filetypes = nil, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
        })
    end
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
        require("lspsaga").setup({
            ui = {
                border = 'rounded',
            },
            symbol_in_winbar = {
                enable = true,
                separator = '  ',
                hide_keyword = true,
                show_file = true,
                folder_level = 2,
                respect_root = false,
                color_mode = true,
            },
            request_timeout = 5000,
        })

    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } }
  },
  {
    "aznhe21/actions-preview.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-telescope/telescope.nvim" },
    opts = {
      handlers = {}
    },
    config = function()
      vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
    end,
  },
  {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
  },
  {
    "saccarosium/nvim-whitespaces",
    lazy = false,
    opts = {
      handlers = {}
    },
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        "<leader>u",
        "<cmd>Telescope undo<cr>",
        desc = "undo history",
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          -- telescope-undo.nvim config, see below
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      handlers = {}
    }
  },
  {
  "olimorris/persisted.nvim",
    lazy = false, 
    config = function()
      require("persisted").setup({
        ignored_dirs = {
          "~/.config",
          "~/.local/nvim",
          { "/", exact = true },
          { "/tmp", exact = true }
        },
        autoload = true,
        on_autoload_no_session = function()
          vim.notify("No existing session to load.")
        end
      })

    end
  },
  { "alexghergh/nvim-tmux-navigation",
    lazy = false,
    config = function()

        local nvim_tmux_nav = require('nvim-tmux-navigation')

        nvim_tmux_nav.setup {
            disable_when_zoomed = true -- defaults to false
        }

        vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
        vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
        vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
        vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
        vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

    end
  },
  {
    "ThePrimeagen/vim-be-good",
    event = "VeryLazy",
  },
  -- {
  --   "tpope/vim-fugitive",
  --   event = "VeryLazy",
  -- },
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
      }
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
      require('lazygit.utils').project_root_dir()
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
        "cpptools",
        "google-java-format",
        "sonarlint-language-server",
        "dockerls",
        "jsonls",
        "lua_ls",
        "yamlls",
      },
    },
    build = ":MasonUpdate",
  }
}
return plugins
