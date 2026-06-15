local ok, opencode = pcall(require, "opencode")
if not ok then return end

-- config
vim.g.opencode_opts = {}
vim.o.autoread = true

vim.keymap.set({ "n", "x" }, "<C-x>", function()
  opencode.select()
end, { desc = "Execute opencode action…" })

vim.keymap.set({ "n", "t" }, "<leader>oa", function()
  opencode.toggle()
end, { desc = "Toggle opencode" })

