local lsp = require('lsp-zero').preset('recommended')
lsp.ensure_installed({
	'tsserver',
	'eslint',
	'rust_analyzer',
	'luau_lsp',
	'clangd',
	'pylsp',

})
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
lsp.setup()

