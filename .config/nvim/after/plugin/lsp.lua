local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr, exclude = {'K'} })
end)

-- here you can setup the language servers
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
	'pyright',
	'ruff_lsp',
    'tsserver',
	'eslint',
	'rust_analyzer',
	'lua_ls',
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    -- pyright configuration
    pyright = function()
        require('lspconfig').pyright.setup({
            settings = {
                pyright = {
                    disableOrganizeImports = true, -- Using Ruff
                },
                python = {
                    analysis = {
                        ignore = { '*' }, -- Using Ruff
                        typeCheckingMode = 'off', -- Using mypy
                    },
                },
            },
        })
    end,

  },
})
