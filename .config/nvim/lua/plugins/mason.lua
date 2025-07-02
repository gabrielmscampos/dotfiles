return {
    "mason-org/mason.nvim",
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "pyright",
                "ruff",
                "eslint",
                "ts_ls",
                "jsonls",
                "cssls",
                "html",
                "rust_analyzer",
                "lua_ls",
                "gopls",
                "clangd"
            }
        })
    end
}
