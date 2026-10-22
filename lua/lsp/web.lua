vim.lsp.config("cssls", {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
})

vim.lsp.config("vtsls", {
	cmd = { "vtsls", "--stdio" },
	settings = {
		javascript = {
			inlayHints = {
				parameterNames = { enabled = "all" },
				variableTypes = { enabled = true },
			},
			format = { enable = true },
		},
	},
	filetypes = { "javascript", "typescript" },
})

vim.lsp.enable({ "cssls", "vtsls" })
