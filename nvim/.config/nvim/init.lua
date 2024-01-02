require("options")
require("remap")

-- move to bottom buffer
vim.keymap.set("n", "<leader>j", "<C-W><C-J>")
-- move to top buffer
vim.keymap.set("n", "<leader>k", "<C-W><C-K>")

-- setup lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

