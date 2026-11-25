vim.lsp.enable("sourcekit") -- Swift
vim.lsp.enable("vtsls") -- Typescript
vim.lsp.enable("lua_ls") -- Lua
vim.lsp.enable("gopls") -- Go
vim.lsp.enable("expert") -- Elixir
vim.lsp.enable("jdtls") -- Java
vim.lsp.enable("kotlin-lsp") -- Kotlin
vim.lsp.enable("basedpyright") -- Python
vim.lsp.enable("postgres_lsp") -- Postgresql
vim.lsp.enable("clangd") -- C
-- vim.lsp.enable("quick-lint-js") -- Javascript
vim.lsp.enable("cssmodules-language-server") -- cssmodules
vim.lsp.enable("css") -- css
-- vim.lsp.enable("biome") -- css
--
local M = { path = {} }

function M.get_typescript_server_path(root_dir)
	local project_roots = vim.fs.find("node_modules", { path = root_dir, upward = true, limit = math.huge })
	for _, project_root in ipairs(project_roots) do
		local typescript_path = project_root .. "/typescript"
		local stat = vim.uv.fs_stat(typescript_path)
		if stat and stat.type == "directory" then
			return typescript_path .. "/lib"
		end
	end
	return ""
end
vim.lsp.config("astro", {
	before_init = function(_, config)
		local tsdk = M.get_typescript_server_path(config.root_dir)
		if tsdk == "" then
			-- local pnpm_root = vim.fn.systemlist("pnpm store path")
			-- if vim.v.shell_error == 0 and pnpm_root[1] then
			-- 	tsdk = pnpm_root[1] .. "/typescript/lib"
			-- end
			tsdk =
				"/home/lawrence/.local/share/pnpm/store/v11/projects/0113fb445b056c6f83c1b14277dc34f2/node_modules/typescript/lib"
		end
		config.init_options = config.init_options or {}
		config.init_options.typescript = config.init_options.typescript or {}
		config.init_options.typescript.tsdk = tsdk
	end,
})
vim.lsp.enable("astro") -- astro
vim.lsp.enable("html") -- html

-- fish
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fish",
	callback = function()
		vim.lsp.start({
			name = "fish-lsp",
			cmd = { "fish-lsp", "start" },
		})
	end,
})
