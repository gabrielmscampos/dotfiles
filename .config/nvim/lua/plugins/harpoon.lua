return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>A", function() harpoon:list():prepend() end, { desc = "Harpoon: prepend" })
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: add" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Harpoon: toggle quick menu" })

        vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end, { desc = "Harpoon: select 1" })
        vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end, { desc = "Harpoon: select 2" })
        vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end, { desc = "Harpoon: select 3" })
        vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end, { desc = "Harpoon: select 4" })
        vim.keymap.set("n", "<C-S-1>", function() harpoon:list():replace_at(1) end,
            { desc = "Harpoon: replace at 1" })
        vim.keymap.set("n", "<C-S-2>", function() harpoon:list():replace_at(2) end,
            { desc = "Harpoon: replace at 2" })
        vim.keymap.set("n", "<C-S-3>", function() harpoon:list():replace_at(3) end,
            { desc = "Harpoon: replace at 3" })
        vim.keymap.set("n", "<C-S-4>", function() harpoon:list():replace_at(4) end,
            { desc = "Harpoon: replace at 4" })

        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon: go to previous buffer" })
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon: go to next buffer" })
    end
}
