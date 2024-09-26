local dap = require('dap')
local dapui = require('dapui')

require("dapui").setup()
require("nvim-dap-virtual-text").setup()


vim.keymap.set('n', '<F8>', function() require('dap').continue() end, { desc = "DAP: Continue" })
vim.keymap.set('n', '<F6>', function() require('dap').step_over() end, { desc = "DAP: Step over" })
vim.keymap.set('n', '<F5>', function() require('dap').step_into() end, { desc = "DAP: Step into" })
vim.keymap.set('n', '<F7>', function() require('dap').step_out() end, { desc = "DAP: Step out" })
vim.keymap.set('n', '<Leader>dt', function() require('dap').toggle_breakpoint() end, { desc = "DAP: Toggle breakpoint" })
vim.keymap.set('n', '<Leader>db', function() require('dap').set_breakpoint() end, { desc = "DAP: Set breakpoint" })
vim.keymap.set('n', '<Leader>dbl',
  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
  { desc = "DAP: Set breakpoint with log point" })
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end,
  { desc = "DAP: Open a REPL / Debug-console" })
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end,
  { desc = "DAP: Re-runs the last debug adapter" })
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end, { desc = "DAP: Hover widget" })
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end, { desc = "DAP: Preview widget" })
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end, { desc = "DAP: Float widget(frames)" })
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end, { desc = "DAP: Float widget(scopes)" })

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

local dappy = require("dap-python")
dappy.setup("python")

for _, v in pairs(dap.configurations.python) do
  v["justMyCode"] = false
end

