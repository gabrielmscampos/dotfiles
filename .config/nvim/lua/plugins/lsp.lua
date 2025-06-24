return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
    },

    config = function()
        local lspconfig_defaults = require("lspconfig").util.default_config
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            lspconfig_defaults.capabilities,
            cmp_lsp.default_capabilities()
        )

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
                vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", keymapOptions("format"))
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

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                -- Bash
                "bashls",
                -- Python
                "basedpyright",
                "ruff",
                -- JavaScript, TypeScript, JSON, HTML, CSS
                "eslint",
                "ts_ls",
                "jsonls",
                "cssls",
                "html",
                -- Rust
                "rust_analyzer",
                -- Lua
                "lua_ls",
                -- Golang
                "gopls",
                -- C/C++
                "clangd"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities
                    })
                end,

                basedpyright = function()
                    require("lspconfig").basedpyright.setup({
                        settings = {
                            disableOrganizeImports = true, -- using Ruff
                            basedpyright = {
                                analysis = {
                                    -- Ignore all files for analysis to exclusively use Ruff for linting
                                    ignore = { "*" },
                                    typeCheckingMode = "off",
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true,
                                    autoImportCompletions = true,
                                    diagnosticMode = "openFilesOnly",
                                    diagnosticSeverityOverrides = {
                                        reportUnknownMemberType = false,
                                        reportUnknownArgumentType = false,
                                        reportUndefinedVariable = false
                                    }
                                }
                            }
                        },
                    })
                end,

                ruff = function()
                    require("lspconfig").ruff.setup {
                        trace = "messages",
                        init_options = {
                            settings = {
                                logLevel = "debug",
                            }
                        }
                    }
                end
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "buffer" }, -- text within current buffer
                { name = "path" },   -- file system paths
            })
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" }
            }
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" }
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" }
                    }
                }
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
