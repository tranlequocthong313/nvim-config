local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
  return
end

local ok_dapui, dapui = pcall(require, "dapui")
if ok_dapui then
  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({ reset = true })
  end

  dap.listeners.before.event_terminated["dapui_config"] = dapui.close

  dap.listeners.before.event_exited["dapui_config"] = dapui.close
end

local ok_virtual_text, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if ok_virtual_text then
  dap_virtual_text.setup()
end

vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "L", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = ">", texthl = "DiagnosticSignHint", linehl = "Visual", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "R", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

local js_debug_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/vscode-js-debug"
local js_debug_server = js_debug_path .. "/out/src/vsDebugServer.js"
local js_adapters = {
  "pwa-node",
  "pwa-chrome",
  "pwa-msedge",
  "node-terminal",
  "pwa-extensionHost",
}

if vim.fn.filereadable(js_debug_server) == 1 then
  local ok_dap_vscode_js, dap_vscode_js = pcall(require, "dap-vscode-js")
  if ok_dap_vscode_js then
    dap_vscode_js.setup({
      debugger_path = js_debug_path,
      adapters = js_adapters,
    })
  else
    vim.notify("nvim-dap-vscode-js is not available", vim.log.levels.WARN)
  end
else
  vim.notify(
    "vscode-js-debug is not built. Run :PackerSync and check " .. js_debug_server,
    vim.log.levels.WARN
  )
end

local js_filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "svelte",
}

for _, language in ipairs(js_filetypes) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "attach",
      processId = require("dap.utils").pick_process,
      name = "Attach debugger to existing `node --inspect` process",
      sourceMaps = true,
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
      cwd = "${workspaceFolder}/src",
      skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
    },
    {
      type = "pwa-chrome",
      name = "Launch Chrome to debug client",
      request = "launch",
      url = "http://localhost:5173",
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}/src",
      skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
    },
    language == "javascript" and {
      type = "pwa-node",
      request = "launch",
      name = "Launch file in new node process",
      program = "${file}",
      cwd = "${workspaceFolder}",
    } or nil,
  }
end

local keymap = vim.keymap
local opts = { silent = true }

keymap.set("n", "<leader>dc", dap.continue, vim.tbl_extend("force", opts, { desc = "DAP continue" }))
keymap.set("n", "<F8>", dap.step_over, vim.tbl_extend("force", opts, { desc = "DAP step over" }))
keymap.set("n", "<F9>", dap.step_into, vim.tbl_extend("force", opts, { desc = "DAP step into" }))
keymap.set("n", "<F10>", dap.step_out, vim.tbl_extend("force", opts, { desc = "DAP step out" }))
keymap.set("n", "<leader>db", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "DAP toggle breakpoint" }))
keymap.set("n", "<leader>du", function()
  if ok_dapui then
    dapui.toggle()
  end
end, vim.tbl_extend("force", opts, { desc = "DAP toggle UI" }))
keymap.set("n", "<leader>dt", dap.terminate, vim.tbl_extend("force", opts, { desc = "DAP terminate" }))
