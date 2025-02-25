return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        local which_key = require("which-key")
        vim.keymap.set("n", "<leader>?", function() which_key.show({ global = false }) end, { desc = "which-key: Buffer local keymaps" })
        vim.keymap.set("n", "<leader>?g", function() which_key.show({ global = true }) end, { desc = "which-key: Buffer global keymaps" })
    end
}
