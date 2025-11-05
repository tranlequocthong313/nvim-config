local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier.with({
            prefer_local = "node_modules/.bin", 
            filetypes = {
                "javascript", "typescript", "typescriptreact",
                "javascriptreact", "json", "html", "css",
                "markdown", "yaml", "scss", "cjs"
            },
            extra_args = { "--config-precedence", "prefer-file" },
        }),
    },
})

vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format current buffer" })
