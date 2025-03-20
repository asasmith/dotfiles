vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dp")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+y")

-- when run in vim should change the current file to and executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x % <CR>")

-- run tmux-sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- last file
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- trouble toggle
-- vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>")

-- :GoRun %
vim.keymap.set("n", "<leader>gr", "<cmd>silent :GoRun % <CR>")

-- :FloatTermNew
vim.keymap.set("n", "<leader>fl", "<cmd>silent :FloatermNew <CR>")
