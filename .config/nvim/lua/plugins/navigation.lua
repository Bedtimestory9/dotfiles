return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			-- REQUIRED
			harpoon:setup()
			-- REQUIRED
			vim.keymap.set("n", "<leader>A", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<leader>a", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
			vim.keymap.set("n", "<leader>1", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<leader>2", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<leader>3", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<leader>4", function()
				harpoon:list():select(4)
			end)
			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-h>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-l>", function()
				harpoon:list():next()
			end)
		end,
	},
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>=",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
	},
	{
		"ibhagwan/fzf-lua",
		config = function()
			vim.keymap.set("n", "<c-z>", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optional but recommended
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},

		require("telescope").setup({
			defaults = {
				preview = {
					treesitter = false,
				},
			},
		}),
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>z", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>r", builtin.resume, { desc = "Search [R]esume" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			-- Grep including ignored
			vim.keymap.set("n", "<leader>si", function()
				builtin.live_grep({
					additional_args = function()
						return { "--no-ignore" }
					end,
				})
			end, { desc = "Live grep for all files" })
			-- Search file including ignored
			vim.keymap.set("n", "<leader>fi", function()
				builtin.find_files({
					no_ignore = true, -- Include ignored files
					hidden = true, -- Optionally include hidden files
				})
			end, { desc = "Find all files" })
		end,
	},
}
