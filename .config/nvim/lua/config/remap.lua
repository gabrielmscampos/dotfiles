-- Go back to file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Beautiful (multi-)line movement in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Copies the selected text to the system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- Copies the current line to the system clipboard
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Easy replace all
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Deletes text to the black hole register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Scrolls down by half a page and centers the cursor vertically
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Scrolls up by half a page and centers the cursor vertically
vim.keymap.set("n", "<C-u>", "<C-u>zz")
