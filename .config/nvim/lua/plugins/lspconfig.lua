return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.lsp.config('*', {
            capabilities = vim.lsp.protocol.make_client_capabilities(),
        })

        -- https://docs.astral.sh/ruff/editors/setup/#neovim
        vim.lsp.config('pyright', {
            settings = {
                pyright = {
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        ignore = { '*' },
                    }
                }
            }
        })

        -- Configure `lua_ls` to get rid of the annoying
        -- "Undefined global `vim`" warning.
        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = {
                            'vim',
                            'require',
                        },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        -- Autocmd for LSP keymaps
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp_key_mappings", { clear = true }),
            desc = "LSP actions",
            callback = function(event)
                local function keymapOptions(desc)
                    return {
                        buffer = event.buf,
                        desc = "LSP: " .. desc,
                    }
                end

                vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", keymapOptions("hover"))
                vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", keymapOptions("definition"))
                vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", keymapOptions("declaration"))
                vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", keymapOptions("implementation"))
                vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", keymapOptions("type definition"))
                vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", keymapOptions("references"))
                vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", keymapOptions("signature help"))
                vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", keymapOptions("rename"))
                vim.keymap.set("n", "<leader>fa", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>",
                    keymapOptions("format"))
                vim.keymap.set("n", "<leader>fi",
                    "<cmd>lua vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })<cr>",
                    keymapOptions("organize imports"))
                vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", keymapOptions("code action"))
            end,
        })

        -- Autocmd to disable hover for Ruff
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
            desc = "LSP: Disable hover capability from Ruff",
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then
                    return
                end
                if client.name == "ruff" then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            end,
        })

        -- Autocmd to format and organize imports on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            callback = function(args)
                vim.lsp.buf.code_action({
                    context = {
                        only = { "source.organizeImports" }
                    },
                    apply = true
                })
                vim.lsp.buf.format({
                    async = false,
                    bufnr = args.buf
                })
            end
        })

        -- Configure diagnostic
        vim.diagnostic.config({
            virtual_text = true,
        })
    end
}
