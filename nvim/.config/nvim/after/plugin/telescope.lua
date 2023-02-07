local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
-- " " + pf
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
-- ctrl + p
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function () 
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>?', builtin.oldfiles, {})
