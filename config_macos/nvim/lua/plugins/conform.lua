local config = function()
	local ok, conform = pcall(require, "conform")
	if not ok then
		return
	end

	conform.setup({
		formatters_by_ft = {
			-- ["_"] = { "trim_whitespace", "trim_newlines" },
			go = { "golangci_lint" },
			python = { "ruff_organize_imports", "ruff_format" },
			lua = { "stylua" },
			dockerfile = { "dockerfmt" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },
			markdown = { "mdformat" },
			json = { "fixjson" },
			toml = { "taplo" },
			nix = { "alejandra" },
			rust = { "rustfmt", lsp_format = "fallback" },
		},
		formatters = {
			golangci_lint = {
				command = "golangci-lint",
				args = { "fmt", "--stdin", "--config", vim.fn.expand("~/.config/golangci-lint/config.yml") },
			},
		},
		format_on_save = {
			timeout_ms = 1000,
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
