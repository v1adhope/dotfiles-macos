local M = {}

M.lua = require('other-modules/plugins/lsp/languages/lua')
M.go = require('other-modules/plugins/lsp/languages/go')
M.json = require('other-modules/plugins/lsp/languages/json')
M.rust = require('other-modules/plugins/lsp/languages/rust')
M.tsserver = require('other-modules/plugins/lsp/languages/tsserver')
M.emmetls = require('other-modules/plugins/lsp/languages/emmetls')
M.php = require('other-modules/plugins/lsp/languages/php')

return M
