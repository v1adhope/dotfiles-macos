-- local file_ext = { "*.go", "*.js", "*.ts", "*.jsx", "*.tsx", "*.rs", "*.php" } -- TODO: php license
local file_ext = { "*.go", "*.js", "*.ts", "*.jsx", "*.tsx", "*.rs" }

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = file_ext,
  callback = function()
    vim.lsp.buf.format(nil, 500)
  end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = file_ext,
  callback = function()
    local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})
