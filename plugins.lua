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
    "simaxme/java.nvim",
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
    config = function()
      require("java").setup()
    end
  },
  {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
  local illuminate = require("illuminate")
      vim.g.Illuminate_ftblacklist = { "NvimTree" }
      vim.api.nvim_set_keymap(
        "n",
        "<a-n>",
        '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
        { noremap = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<a-p>",
        '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
        { noremap = true }
      )

      illuminate.configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 200,
        filetypes_denylist = {
          "dirvish",
          "fugitive",
          "alpha",
          "NvimTree",
          "packer",
          "neogitstatus",
          "Trouble",
          "lir",
          "Outline",
          "spectre_panel",
          "toggleterm",
          "DressingSelect",
          "TelescopePrompt",
          "sagafinder",
          "sagacallhierarchy",
          "sagaincomingcalls",
          "sagapeekdefinition",
        },
        filetypes_allowlist = {},
        modes_denylist = {},
        modes_allowlist = {},
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},
        under_cursor = true,
      })
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      branch = "main",
      event = "BufEnter",
      config = function()
        require("lsp_lines").setup()
      end
  },
  {
    "gen740/SmoothCursor.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      local default = {
        autostart = true,
        cursor = "", -- cursor shape (need nerd font)
        intervals = 35, -- tick interval
        linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
        type = "exp", -- define cursor movement calculate function, "default" or "exp" (exponential).
        fancy = {
          enable = true, -- enable fancy mode
          head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
          body = {
            { cursor = "", texthl = "SmoothCursorRed" },
            { cursor = "", texthl = "SmoothCursorOrange" },
            { cursor = "●", texthl = "SmoothCursorYellow" },
            { cursor = "●", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = ".",   texthl = "SmoothCursorBlue" },
            { cursor = ".",   texthl = "SmoothCursorPurple" },
          },
          tail = { cursor = nil, texthl = "SmoothCursor" },
        },
        priority = 10, -- set marker priority
        speed = 25, -- max is 100 to stick to your current position
        texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
        threshold = 3,
        timeout = 3000,
        disable_float_win = true, -- disable on float window
      }
      require("smoothcursor").setup(default)
      end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
   config = function()
      local keymap = vim.keymap

      require('lspsaga').setup {
        ui = {
          border = 'rounded',
        },
        lightbulb = {
          enable = false,
        },
      }

      keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>')
      keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>')
      keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<cr>')

      local builtin = require 'telescope.builtin'

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<cr>', opts)
          vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
          vim.keymap.set(
            { 'n', 'v' },
            '<leader>ca',
            '<cmd>Lspsaga code_action<cr>',
            opts
          )
          vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
        end,
      })

      vim.keymap.set(
        'n',
        '<space>k',
        '<cmd>Lspsaga hover_doc<cr>',
        { silent = true }
      )

      -- error lens
      vim.fn.sign_define {
        {
          name = 'DiagnosticSignError',
          text = '',
          texthl = 'DiagnosticSignError',
          linehl = 'ErrorLine',
        },
        {
          name = 'DiagnosticSignWarn',
          text = '',
          texthl = 'DiagnosticSignWarn',
          linehl = 'WarningLine',
        },
        {
          name = 'DiagnosticSignInfo',
          text = '',
          texthl = 'DiagnosticSignInfo',
          linehl = 'InfoLine',
        },
        {
          name = 'DiagnosticSignHint',
          text = '',
          texthl = 'DiagnosticSignHint',
          linehl = 'HintLine',
        },
      }
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
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
    dependencies = { "mfussenegger/nvim-jdtls" },
    event = { "BufRead", "BufNewFile" },
    opts = {
      handlers = {}
    },
    config = function()
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
    end
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
  {
    "mfussenegger/nvim-jdtls",
    event = { "BufRead", "BufNewFile" },
    ft = "java",

    dependencies = {
        "williamboman/mason.nvim",
        "hrsh7th/nvim-cmp",
    },

    config = function()
      local java_cmds = vim.api.nvim_create_augroup('java_cmds', {clear = true})
      local cache_vars = {}

      local root_files = {
        '.git',
        'mvnw',
        'gradlew',
        'pom.xml',
        'build.gradle',
      }

      local features = {
        -- change this to `true` to enable codelens
        codelens = false,

        -- change this to `true` if you have `nvim-dap`,
        -- `java-test` and `java-debug-adapter` installed
        debugger = true,
      }

      local function get_jdtls_paths()
        if cache_vars.paths then
          return cache_vars.paths
        end

        local path = {}

        path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'

        local jdtls_install = require('mason-registry')
          .get_package('jdtls')
          :get_install_path()

        path.java_agent = jdtls_install .. '/lombok.jar'
        path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')

        if vim.fn.has('mac') == 1 then
          path.platform_config = jdtls_install .. '/config_mac'
        elseif vim.fn.has('unix') == 1 then
          path.platform_config = jdtls_install .. '/config_linux'
        elseif vim.fn.has('win32') == 1 then
          path.platform_config = jdtls_install .. '/config_win'
        end

        path.bundles = {}

        ---
        -- Include java-test bundle if present
        ---
        local java_test_path = require('mason-registry')
          .get_package('java-test')
          :get_install_path()

        local java_test_bundle = vim.split(
          vim.fn.glob(java_test_path .. '/extension/server/*.jar'),
          '\n'
        )

        if java_test_bundle[1] ~= '' then
          vim.list_extend(path.bundles, java_test_bundle)
        end

        ---
        -- Include java-debug-adapter bundle if present
        ---
        local java_debug_path = require('mason-registry')
          .get_package('java-debug-adapter')
          :get_install_path()

        local java_debug_bundle = vim.split(
          vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'),
          '\n'
        )

        if java_debug_bundle[1] ~= '' then
          vim.list_extend(path.bundles, java_debug_bundle)
        end

        ---
        -- Useful if you're starting jdtls with a Java version that's 
        -- different from the one the project uses.
        ---
        path.runtimes = {
          -- Note: the field `name` must be a valid `ExecutionEnvironment`,
          -- you can find the list here: 
          -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
          --
          -- This example assume you are using sdkman: https://sdkman.io
          {
            name = 'JavaSE-21',
            path = vim.fn.expand('~/.sdkman/candidates/java/current'),
          },
          -- {
          --   name = 'JavaSE-18',
          --   path = vim.fn.expand('~/.sdkman/candidates/java/18.0.2-amzn'),
          -- },
        }

        cache_vars.paths = path

        return path
      end

      local function enable_codelens(bufnr)
        pcall(vim.lsp.codelens.refresh)

        vim.api.nvim_create_autocmd('BufWritePost', {
          buffer = bufnr,
          group = java_cmds,
          desc = 'refresh codelens',
          callback = function()
            pcall(vim.lsp.codelens.refresh)
          end,
        })
      end

      local function enable_debugger(bufnr)
        require('jdtls').setup_dap({hotcodereplace = 'auto'})
        require('jdtls.dap').setup_dap_main_class_configs()
        require("jdtls.setup").add_commands()

        local opts = {buffer = bufnr}
        vim.keymap.set('n', '<leader>df', "<cmd>lua require('jdtls').test_class()<cr>", opts)
        vim.keymap.set('n', '<leader>dn', "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)
      end

      local function print_test_results(items)
        if #items > 0 then
          vim.cmd([[Trouble quickfix]])
        else
          vim.cmd([[TroubleClose quickfix]])
        end
      end

      local function jdtls_on_attach(client, bufnr)
        if features.debugger then
          enable_debugger(bufnr)
        end

        if features.codelens then
          enable_codelens(bufnr)
        end

        -- The following mappings are based on the suggested usage of nvim-jdtls
        -- https://github.com/mfussenegger/nvim-jdtls#usage
        
        local opts = {buffer = bufnr}
        vim.keymap.set('n', '<A-o>', "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
        vim.keymap.set('n', 'crv', "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
        vim.keymap.set('x', 'crv', "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
        vim.keymap.set('n', 'crc', "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
        vim.keymap.set('x', 'crc', "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
        vim.keymap.set('x', 'crm', "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts)
        vim.keymap.set("n", "<leader>ht", function()
          require("jdtls").pick_test({ bufnr = buffer, after_test = print_test_results })
        end, { buffer = buffer, desc = "Run Test" })
      end

      local function jdtls_setup(event)
        local jdtls = require('jdtls')

        local path = get_jdtls_paths()
        local data_dir = path.data_dir .. '/' ..  vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

        if cache_vars.capabilities == nil then
          jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
          jdtls.extendedClientCapabilities.progressReportProvider = false

          local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
          cache_vars.capabilities = vim.tbl_deep_extend(
            'force',
            vim.lsp.protocol.make_client_capabilities(),
            ok_cmp and cmp_lsp.default_capabilities() or {}
          )
        end

        -- The command that starts the language server
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        local cmd = {
          -- 💀
          'java',

          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-javaagent:' .. path.java_agent,
          '-Xms2G',
          '--add-modules=ALL-SYSTEM',
          '--add-opens',
          'java.base/java.util=ALL-UNNAMED',
          '--add-opens',
          'java.base/java.lang=ALL-UNNAMED',
          
          -- 💀
          '-jar',
          path.launcher_jar,

          -- 💀
          '-configuration',
          path.platform_config,

          -- 💀
          '-data',
          data_dir,
        }

        local lsp_settings = {
          java = {
            -- jdt = {
            --   ls = {
            --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx2G -Xms512m"
            --   }
            -- },
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = 'interactive',
              runtimes = path.runtimes,
            },
            maven = {
              downloadSources = true,
            },
            implementationsCodeLens = {
              enabled = false,
            },
            references = {
              includeDecompiledSources = true,
            },
            referencesCodeLens = {
              enabled = false,
            },
            inlayHints = {
              parameterNames = {
                enabled = 'all' -- literals, all, none
              },
            },
            format = {
              enabled = false,
              -- settings = {
              --   profile = 'asdf'
              -- },
            }
          },
          signatureHelp = {
            enabled = true,
          },
          completion = {
            favoriteStaticMembers = {
              'org.hamcrest.MatcherAssert.assertThat',
              'org.hamcrest.Matchers.*',
              'org.hamcrest.CoreMatchers.*',
              'org.junit.jupiter.api.Assertions.*',
              'java.util.Objects.requireNonNull',
              'java.util.Objects.requireNonNullElse',
              'org.mockito.Mockito.*',
            },
          },
          contentProvider = {
            preferred = 'fernflower',
          },
          extendedClientCapabilities = jdtls.extendedClientCapabilities,
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            }
          },
          codeGeneration = {
            toString = {
              template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
            },
            useBlocks = true,
          },
        }

        -- This starts a new client & server,
        -- or attaches to an existing client & server depending on the `root_dir`.
        jdtls.start_or_attach({
          cmd = cmd,
          settings = lsp_settings,
          on_attach = jdtls_on_attach,
          handlers = {
            -- ["language/status"] = function()
              -- print(result)
            -- end,
            ["$/progress"] = function()
              -- disable progress updates.
            end,
          },
          capabilities = cache_vars.capabilities,
          root_dir = jdtls.setup.find_root(root_files),
          flags = {
            allow_incremental_sync = false,
            server_side_fuzzy_completion = true,
          },
          init_options = {
            bundles = path.bundles,
          },
        })
        end

        vim.api.nvim_create_autocmd('FileType', {
          group = java_cmds,
          pattern = {'java'},
          desc = 'Setup jdtls',
          callback = jdtls_setup,
        })
      end
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
    "jvgrootveld/telescope-zoxide",
    dependencies =  {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    },
    event = "VeryLazy",
    opts = {
      handlers = {}
    },
    config = function()
      require("telescope").load_extension("zoxide")
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
      "mfussenegger/nvim-lint",
      event = {
        "BufReadPre",
        "BufNewFile",
      },
      config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
          javascript = { "eslint_d" },
          typescript = { "eslint_d" },
          javascriptreact = { "eslint_d" },
          typescriptreact = { "eslint_d" },
          cpp = { "cpplint" },
          kotlin = { "ktlint" },
          terraform = { "tflint" },
          python = { "ruff" },
          java = { "checkstyle" },
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
          group = lint_augroup,
          callback = function()
            lint.try_lint()
          end,
        })

        vim.keymap.set("n", "<leader>ll", function()
          lint.try_lint()
        end, { desc = "Trigger linting for current file" })
      end,
    },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          cpp = { "clang-format " },
          python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
              return { "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          javascript = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          typescriptreact = { { "prettierd", "prettier" } },
          json = { { "prettierd", "prettier" } },
          graphql = { { "prettierd", "prettier" } },
          java = { "google-java-format" },
          kotlin = { "ktlint" },
          markdown = { { "prettierd", "prettier" } },
          erb = { "htmlbeautifier" },
          html = { "htmlbeautifier" },
          bash = { "beautysh" },
          proto = { "buf" },
          yaml = { "yamlfix" },
          toml = { "taplo" },
          css = { { "prettierd", "prettier" } },
          scss = { { "prettierd", "prettier" } },
        },
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_fallback = true,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>l", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
    },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local mason = require("mason")
      require("mason-lspconfig").setup()

      local mason_tool_installer = require("mason-tool-installer")

      -- enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "ktlint",
          "clangd",
          "clang-format",
          "codelldb",
          "cpptools",
          "google-java-format",
          "sonarlint-language-server",
          "checkstyle",
          "vscode-java-decompiler",
          "jdtls",
          "java-debug-adapter",
          "java-test",
          "checkstyle",
          "cpplint",
          "beautysh",
          "yamlfix",
          "prettierd",
          "ruff",
          "pyright",
          "ruff-lsp",
          "prettier",
          "debugpy", -- debugger
          "black", -- formatter
          "isort", -- organize imports
          "taplo", -- LSP for toml (for pyproject.toml files)
        },
        automatic_installation = true,
        integrations = {
          ["mason-lspconfig"] = true,
          ["mason-nvim-dap"] = true,
        }
      })
    end,
  },
  {
  "mfussenegger/nvim-dap-python",
    ft = { "python" },
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      -- uses the debugypy installation by mason
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
    end,
  },
  -- auto pairing
  { "echasnovski/mini.pairs", event="VeryLazy",
    config = function(_, opts)
      require('mini.pairs').setup(opts)
    end
  },
  { "rockerBOO/symbols-outline.nvim", event="VeryLazy",
    config = function(_, opts)
      require('symbols-outline').setup(opts)
    end
  },

  -- surround text object
  { "echasnovski/mini.surround",
    config = function(_, opts)
      require('mini.surround').setup(opts)
    end
  },
  {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  opts = {
    -- Your options go here
    -- name = "venv",
    -- auto_refresh = false
  },
  event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  },
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    event = "VeryLazy",
  }
}
return plugins
