local ok, _ = pcall(require, 'lsp_configs/mason')
if not ok then
  return
end

local ok, config = pcall(require, 'lspconfig')
if not ok then
  return
end

local ok, handlers = pcall(require, 'lsp_configs/handlers')
if not ok then
  return
end

local ok, languages = pcall(require, 'lsp_configs/languages')
if not ok then
  return
end

for _, lsp in ipairs(Servers) do
  if lsp == 'emmet_ls' then
    config[lsp].setup {
      filetypes = languages.emmetls['filetypes']
    }
  end

  config[lsp].setup {
    on_attach = function(client, bufnr)
      handlers.custom_lsp_attach(client, bufnr)
    end,
    capabillities = handlers.capabilities,
    settings = {
      Lua = languages.lua,
      json = languages.json,
      gopls = languages.go,
      rust = languages.rust,
      tsserver = languages.tsserver,
      -- php = languages.php
    }
  }
end
