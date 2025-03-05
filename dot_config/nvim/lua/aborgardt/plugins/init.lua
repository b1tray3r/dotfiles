return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = {
			direction = "vertical",
		},
		keys = {
			{ "<leader>tf", ":ToggleTerm direction=float size=80<cr>", desc = "ToggleTerm" },
			{ "<leader>tt", ":ToggleTerm size=80<cr>", desc = "ToggleTerm" },
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
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
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- config
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{ -- LazyGit in my NeoVim
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{ -- Jump around like a kangaroo
		"ggandor/leap.nvim",
		lazy = false,
		opts = {
			case_sensitive = false,
			safe_labels = {},
			max_phase_one_targets = 0,
			max_highlighted_traversal_targets = 10,
			labels = "jklasdfghqwertyuiopzxcvbnm",
		},

		config = function(_, opts)
			local leap = require("leap")
			leap.setup(opts)

			-- Bidirectional search
			vim.keymap.set("n", "s", function()
				leap.leap({ target_windows = { vim.api.nvim_get_current_win() } })
			end)
			vim.keymap.set("x", "s", function()
				leap.leap({ target_windows = { vim.api.nvim_get_current_win() } })
			end)
		end,
	},
	{ -- small and pretty status line
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "folke/tokyonight.nvim" },
		config = function()
			require("lualine").setup({ options = { theme = "tokyonight" } })
		end,
	},
	{ -- file tree and open buffer list
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle left<CR>", {})
			vim.keymap.set("n", "<leader>v", ":Neotree buffers toggle right<CR>", {})
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
		"rafaelsq/nvim-goc.lua",
		config = function()
			-- if set, when we switch between buffers, it will not split more than once. It will switch to the existing buffer instead
			vim.opt.switchbuf = "useopen"

			local goc = require("nvim-goc")
			goc.setup({ verticalSplit = true })

			vim.keymap.set("n", "<Leader>cf", goc.Coverage, { silent = true }) -- run for the whole File
			vim.keymap.set("n", "<Leader>ct", goc.CoverageFunc, { silent = true }) -- run only for a specific Test unit
			vim.keymap.set("n", "<Leader>cc", goc.ClearCoverage, { silent = true }) -- clear coverage highlights

			-- If you need custom arguments, you can supply an array as in the example below.
			vim.keymap.set("n", "<Leader>crf", function()
				goc.Coverage({ "-race", "-count=1" })
			end, { silent = true })
			vim.keymap.set("n", "<Leader>crt", function()
				goc.CoverageFunc({ "-race", "-count=1" })
			end, { silent = true })

			cf = function(testCurrentFunction)
				local cb = function(path)
					if path then
						vim.cmd(':silent exec "!xdg-open ' .. path .. '"')
					end
				end

				if testCurrentFunction then
					goc.CoverageFunc(nil, cb, 0)
				else
					goc.Coverage(nil, cb)
				end
			end
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = false,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					go = true,
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
			})
		end,
	},
}
