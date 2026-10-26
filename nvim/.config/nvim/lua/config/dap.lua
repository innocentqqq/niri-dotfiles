-- lua/config/dap.lua

local dap = require('dap')

local function get_python_path()
  local venv_path = vim.fn.getcwd() .. '/.venv/bin/python'
  if vim.fn.executable(venv_path) == 1 then
    return venv_path
  end
  venv_path = vim.fn.getcwd() .. '/venv/bin/python'
  if vim.fn.executable(venv_path) == 1 then
    return venv_path
  end
  return 'python3' -- Fallback to system python (install debugpy there)
end

dap.adapters.python = {
  type = 'executable',
  command = get_python_path(),
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = get_python_path,
    console = 'integratedTerminal',
  },
}

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
