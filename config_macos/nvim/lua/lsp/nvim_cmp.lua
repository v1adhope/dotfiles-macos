local ok, cmp = pcall(require, "cmp")
if not ok then
	return
end

local ok, luasnip = pcall(require, "luasnip")
if not ok then
	return
end

local ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not ok then
	return
end

local ok, friendly_snippets = pcall(require, "luasnip.loaders.from_vscode")
if not ok then
	return
end

friendly_snippets.lazy_load({ exclude = {} })

-- Correct work cmp with luasnip
local has_words_before = function()
	unpack = unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Insert `()` after select function or method item
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup({
	completion = { autocomplete = false },
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
	cmp.setup.filetype({ "markdown", "yaml", "json" }, {
		sources = {
			{ name = "buffer" },
		},
	}),
})
