-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
-- Save undo history
vim.opt.undofile = true
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.schedule(function()
	vim.opt.clipboard = "unnamed"
	vim.opt.clipboard = "unnamedplus" -- for MacOS
end)

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- No wrap
vim.keymap.set("n", "<C-w>", "<cmd>set wrap!<cr>", { desc = "[W]rap text" })
-- DiffviewOpen/Close
vim.keymap.set("n", "<leader>df", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
vim.keymap.set("n", "<leader>dr", "<cmd>DiffviewRefresh<cr>", { desc = "Refresh Diffview" })

vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 12
-- Treesitter-context
vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

vim.keymap.set("n", "<Tab>", ">>")
vim.keymap.set("n", "<S-Tab>", "<<")
vim.keymap.set("v", "<Tab>", ">>")
vim.keymap.set("v", "<S-Tab>", "<<")
-- Distinguish <Tab> from <C-i> in normal mode
vim.keymap.set("n", "<C-i>", "<C-i>")
-- See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<leader>h", "<cmd>wincmd h<cr>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<leader>l", "<cmd>wincmd l<cr>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<leader>j", "<cmd>wincmd j<cr>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<leader>k", "<cmd>wincmd k<cr>", { desc = "Move focus to the upper window" })

-- My own opts
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false
vim.opt.termguicolors = true
-- Visuals
vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = "rounded"

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gitcommit", "gitrebase", "gitconfig" },
	callback = function()
		vim.bo.bufhidden = "delete"
	end,
})

-- Make help window vertically right
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("help_window_right", {}),
	pattern = { "*.txt", "*.md" },
	callback = function()
		vim.cmd.wincmd("L")
	end,
})
