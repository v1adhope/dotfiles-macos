local config = function()
	local ok, conform = pcall(require, "conform")
	if not ok then
		return
	end

	conform.setup({
		formatters_by_ft = {
			go = {
				"goimports",
				"gofmt",
			},
			python = {
				"ruff_organize_imports",
				"ruff_format",
			},
			lua = {
				"stylua",
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})
end

return {
	{
		"stevearc/conform.nvim",
		config = config,
	},
}
