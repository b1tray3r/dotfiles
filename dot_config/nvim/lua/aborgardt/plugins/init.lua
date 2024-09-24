return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      messages = {
        enabled = false,
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  { -- LazyGit in my NeoVim
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  { -- Jump around like a kangaroo
    'ggandor/leap.nvim',
    lazy = false,
    opts = {
      case_sensitive = false,
      safe_labels = {},
      max_phase_one_targets = 0,
      max_highlighted_traversal_targets = 10,
      labels = 'jklasdfghqwertyuiopzxcvbnm',
    },

    config = function(_, opts)
      local leap = require 'leap'
      leap.setup(opts)

      -- Bidirectional search
      vim.keymap.set('n', 's', function()
        leap.leap { target_windows = { vim.api.nvim_get_current_win() } }
      end)
      vim.keymap.set('x', 's', function()
        leap.leap { target_windows = { vim.api.nvim_get_current_win() } }
      end)
    end,
  },
  { -- small and pretty status line
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
    config = function()
      require('lualine').setup { options = { theme = 'catppuccin' } }
    end,
  },
  { -- file tree and open buffer list
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>e', ':Neotree filesystem toggle left<CR>', {})
      vim.keymap.set('n', '<leader>v', ':Neotree buffers toggle right<CR>', {})
    end,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            -- '.git',
            -- '.DS_Store',
            -- 'thumbs.db',
          },
          never_show = {},
        },
      },
    },
  },
  {
    'rafaelsq/nvim-goc.lua',
    config = function()
      -- if set, when we switch between buffers, it will not split more than once. It will switch to the existing buffer instead
      vim.opt.switchbuf = 'useopen'

      local goc = require 'nvim-goc'
      goc.setup { verticalSplit = true }

      vim.keymap.set('n', '<Leader>cf', goc.Coverage, { silent = true }) -- run for the whole File
      vim.keymap.set('n', '<Leader>ct', goc.CoverageFunc, { silent = true }) -- run only for a specific Test unit
      vim.keymap.set('n', '<Leader>cc', goc.ClearCoverage, { silent = true }) -- clear coverage highlights

      -- If you need custom arguments, you can supply an array as in the example below.
      vim.keymap.set('n', '<Leader>crf', function()
        goc.Coverage { '-race', '-count=1' }
      end, { silent = true })
      vim.keymap.set('n', '<Leader>crt', function()
        goc.CoverageFunc { '-race', '-count=1' }
      end, { silent = true })

      cf = function(testCurrentFunction)
        local cb = function(path)
          if path then
            -- `xdg-open|open` command performs the same function as double-clicking on the file.
            -- change from `xdg-open` to `open` on MacOSx
            vim.cmd(':silent exec "!xdg-open ' .. path .. '"')
          end
        end

        if testCurrentFunction then
          goc.CoverageFunc(nil, cb, 0)
        else
          goc.Coverage(nil, cb)
        end
      end

      -- default colors
      -- vim.api.nvim_set_hl(0, 'GocNormal', {link='Comment'})
      -- vim.api.nvim_set_hl(0, 'GocCovered', {link='String'})
      -- vim.api.nvim_set_hl(0, 'GocUncovered', {link='Error'})
    end,
  },
}
