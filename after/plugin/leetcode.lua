local function leet(args)
    return function()
        vim.cmd("Leet " .. args)
    end
end

require("leetcode").setup({
    lang = "javascript",
})

local opts = { silent = true }
local keymap = vim.keymap.set

keymap("n", "<leader>ll", leet("list"), vim.tbl_extend("force", opts, { desc = "Leet list problems" }))
keymap("n", "<leader>lt", leet("tabs"), vim.tbl_extend("force", opts, { desc = "Leet tabs" }))

keymap("n", "<leader>lr", leet("run"), vim.tbl_extend("force", opts, { desc = "Leet run" }))
keymap("n", "<leader>ls", leet("submit"), vim.tbl_extend("force", opts, { desc = "Leet submit" }))
keymap("n", "<leader>lg", leet("lang"), vim.tbl_extend("force", opts, { desc = "Leet change language" }))
keymap("n", "<leader>lc", leet("console"), vim.tbl_extend("force", opts, { desc = "Leet console" }))

keymap("n", "<leader>lx", leet("desc"), vim.tbl_extend("force", opts, { desc = "Leet toggle description" }))
