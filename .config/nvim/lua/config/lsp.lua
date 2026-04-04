vim.lsp.enable("sourcekit")
vim.lsp.enable("vtsls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("gopls")
vim.lsp.enable("expert")
vim.lsp.enable("jdtls")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "fish",
	callback = function()
		vim.lsp.start({
			name = "fish-lsp",
			cmd = { "fish-lsp", "start" },
		})
	end,
})
