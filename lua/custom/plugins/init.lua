-- Sync with stylua's .stylua.toml formatting rules
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.schedule(function()
  local is_devcontainer = os.getenv 'REMOTE_CONTAINERS' or os.getenv 'CODESPACES' or os.getenv 'DEVCONTAINER' or vim.fn.filereadable '/.dockerenv' == 1

  if is_devcontainer then
    vim.g.clipboard = {
      name = 'OSC 52',
      copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy '+',
        ['*'] = require('vim.ui.clipboard.osc52').copy '*',
      },
      paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste '+',
        ['*'] = require('vim.ui.clipboard.osc52').paste '*',
      },
    }
  end
end)

-- Do things without affecting the registers
vim.keymap.set('n', 'x', '"_x')

-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {}
