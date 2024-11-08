return {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("lazygit")
        vim.keymap.set("n", "<leader>lg", ":LazyGit<CR>", { desc = "LazyGit: Open" })
    end
}
