return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({})

        local builtin = require("telescope.builtin")
        local ps = function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end
        local fr = function()
            require("telescope.builtin").lsp_references()
        end

        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>gf", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>ps", ps)
        vim.keymap.set("n", "<leader>fr", fr, { noremap = true, silent = true })
    end
}
