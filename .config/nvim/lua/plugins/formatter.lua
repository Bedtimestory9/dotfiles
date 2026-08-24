return {
	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				filetype = {
					"html",
					"xml",
					"javascript",
					"typescript",
					"javascriptreact",
					"typescriptreact",
					"vue",
					"svelte",
					"astro",
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				-- per_filetype = {
				-- 	["html"] = {
				-- 		enable_close = false,
				-- 	},
				-- },
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd", stop_after_first = true },
				typescript = { "prettierd", stop_after_first = true },
				json = { "prettierd", stop_after_first = true },
				jsonc = { "prettierd", stop_after_first = true },
				elixir = { "mix" },
				eelixir = { "mix" },
				heex = { "mix" },
				surface = { "mix" },
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 1000 },
			-- Customize formatters
			formatters = {
				shfmt = {
					append_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "elixir" },
			highlight = {
				enable = true,
			},
		},
		--WARN: Without this line, Elixir will not highlight
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local ft = args.match
					pcall(vim.treesitter.start, 0, ft)
				end,
			})
		end,
	},
	{
		"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	},
	{
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({
				vim.keymap.set("n", "<leader>c", "<cmd>:HighlightColors Toggle<cr>"),
			})
		end,
	},
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
			-- require("mini.icons").setup()
			require("mini.git").setup()
			require("mini.indentscope").setup({
				draw = {
					delay = 100,
				},
				symbol = "|",
			})
		end,
	},
}
