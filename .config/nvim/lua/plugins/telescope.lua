return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({})
        local builtin = require("telescope.builtin")

        -- file pickers
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: find files" })
        vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Telescope: git files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: live_grep" })
        vim.keymap.set("n", "<leader>gs", builtin.grep_string, { desc = "Telescope: grep string under cursor" })
        vim.keymap.set("n", "<leader>ps", function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end,
            { desc = "Telescope: grep for any string" })

        -- vim pickers
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: open buffers" })

        -- neovim lsp pickers
        vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Telescope: lsp references" })
    end
}
