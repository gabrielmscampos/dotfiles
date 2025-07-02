return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        local toggleterm = require("toggleterm")

        toggleterm.setup({
            size = 20,
            shade_terminals = false,
            shading_factor = 0,
            open_mapping = [[<c-t>]],
            on_open = function()
                vim.cmd("setlocal number")
            end
        })
    end
}
