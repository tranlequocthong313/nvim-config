vim.g.lazygit_floating_window_scaling_factor = 1.0     -- full width/height
vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_border_chars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' }

vim.keymap.set("n", "<leader>gs", vim.cmd.LazyGit)
