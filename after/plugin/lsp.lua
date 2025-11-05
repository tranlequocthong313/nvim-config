vim.lsp.enable('ts_ls')
vim.lsp.enable('tailwindcss')
vim.lsp.enable('html')
vim.lsp.enable('cssls')
vim.lsp.enable('emmet_ls')
vim.lsp.enable('eslint')
vim.lsp.enable('null-ls')

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), 
    ['<C-e>'] = cmp.mapping.abort(), 
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

local keymap = vim.keymap

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local opts = { buffer = ev.buf, silent = true }

    local disabled_formatters = { "ts_ls", "html", "cssls", "jsonls" }
    if vim.tbl_contains(disabled_formatters, client.name) then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    keymap.set("n", "K", vim.lsp.buf.hover, opts)
    keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
  end,
})
