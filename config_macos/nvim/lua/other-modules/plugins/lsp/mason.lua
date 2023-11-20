local ok, mason = pcall(require, 'mason')
if not ok then
  return
end

mason.setup {
  -- log_level = vim.log.levels.DEBUG,
  -- install_root_dir = path.concat { vim.fn.stdpath "config", "mason" },
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}

local ok, mason_lsp = pcall(require, 'mason-lspconfig')
if not ok then
  return
end

-- Connecting servers
-- require node(npm)
Servers = { 'lua_ls', 'gopls', 'bashls', 'jsonls', 'emmet_ls', 'html', 'rust_analyzer', 'tsserver' }

mason_lsp.setup {
  ensure_install = { Servers },
  automatic_installation = true
}
