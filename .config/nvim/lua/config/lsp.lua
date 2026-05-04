vim.lsp.enable("sourcekit")
vim.lsp.enable("vtsls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("gopls")
vim.lsp.enable("expert")
vim.lsp.enable("jdtls")
vim.lsp.enable("kotlin-lsp")
vim.lsp.enable("css")
vim.lsp.enable("html")
vim.lsp.enable("basedpyright")
vim.lsp.enable("postgres_lsp")
vim.lsp.enable("clangd")
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fish",
	callback = function()
		vim.lsp.start({
			name = "fish-lsp",
			cmd = { "fish-lsp", "start" },
		})
	end,
})
