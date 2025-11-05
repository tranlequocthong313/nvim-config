local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Fuzzy finding' })
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({search = vim.fn.input("Grep > ")})
end)

require("telescope").setup({
    pickers = {
        find_files = {
            previewer = false,        -- remove preview for specific picker
        },
        git_files = {
            previewer = false,        -- remove preview for specific picker
        }
    }
})
