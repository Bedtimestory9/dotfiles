return {
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = {
		"tsconfig.json",
		"jsconfig.json",
		"package.json",
		".git",
	},
	settings = {
		vtsls = {
			autoUseWorkspaceTsdk = true,
		},
		typescript = {
			suggest = {
				completeFunctionCalls = true,
			},
		},
	},
}
