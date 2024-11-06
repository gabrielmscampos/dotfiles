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
    'basedpyright',
    'ruff',
    'eslint',
    'ts_ls',
    'rust_analyzer',
    'lua_ls',
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,

    -- pyright configuration
    basedpyright = function()
        require('lspconfig').basedpyright.setup({
            settings = {
                disableOrganizeImports = true,
                basedpyright = {
                    analysis = {
                        typeCheckingMode = 'standard',
                        diagnosticMode = 'openFilesOnly'
                    }
                }
            },
        })
    end,

  },
})
