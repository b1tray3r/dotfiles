vim.g.mapleader = " "
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.o.breakindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.inccommand = 'split'
vim.o.list = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.winborder = "rounded"
vim.o.wrap = false

-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open [d]iagnostic quickfix list' })
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Plugins
vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
})

-- Completion (nvim-cmp, without LuaSnip)
local cmp = require("cmp")
cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
})
vim.cmd("set completeopt=menu,menuone,noselect")

-- LSP Setup
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- gopls configuration
lspconfig.gopls.setup({
	capabilities = cmp_nvim_lsp.default_capabilities(),
	settings = {
		gopls = {
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
				nilness = true,
				unusedwrite = true,
				useany = true,
			},
			staticcheck = true,
		},
	},
})

-- Other LSPs
vim.lsp.enable({ "lua_ls", "intelephense", "dockerls", "docker_compose_language_service" })

-- On LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = 'Go to definition' })
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = 'Go to references' })

		-- Format and organize imports on save using LSP code actions
		vim.api.nvim_create_autocmd("BufWritePre", {
		  buffer = ev.buf,
		  callback = function()
		    local client = vim.lsp.get_client_by_id(ev.data.client_id)
		    local params = vim.lsp.util.make_range_params(nil, client.offset_encoding or "utf-16")
		    params.context = { only = { "source.organizeImports" } }
		
		    local result = vim.lsp.buf_request_sync(ev.buf, "textDocument/codeAction", params, 1000)
		    for _, res in pairs(result or {}) do
		      for _, action in pairs(res.result or {}) do
		        if action.edit or type(action.command) == "table" then
		          if action.edit then
		            vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
		          end
		          if type(action.command) == "table" then
		            vim.lsp.buf.execute_command(action.command)
		          end
		        else
		          vim.lsp.buf.execute_command(action)
		        end
		      end
		    end
		
		    vim.lsp.buf.format({ async = false })
		  end,
		})
	end,
})

-- Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "python", "php", "dockerfile" },
	highlight = { enable = true }
})

-- Mini.pick
require("mini.pick").setup()

-- Oil
require("oil").setup()

-- Theme
require("tokyonight").setup({
	style = 'night',
	transparent = true,
})
vim.cmd("colorscheme tokyonight")
vim.cmd(":hi statusline guibg=NONE")

-- Plugin-related keymaps
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
vim.keymap.set('n', '<leader>F', vim.lsp.buf.format)
