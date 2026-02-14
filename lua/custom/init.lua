vim.g.have_nerd_font = true
vim.o.relativenumber = true

-- Sync with stylua's .stylua.toml formatting rules
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Do things without affecting the registers
vim.keymap.set('n', 'x', '"_x')

-- Enable automatic reading of external changes
vim.opt.autoread = true

-- Check file changes when focus returns to neovim
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  command = 'checktime',
})
