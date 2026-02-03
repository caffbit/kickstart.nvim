vim.g.have_nerd_font = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes:1'

-- Sync with stylua's .stylua.toml formatting rules
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Do things without affecting the registers
vim.keymap.set('n', 'x', '"_x')

-- Enable automatic reading of external changes
vim.opt.autoread = true

-- Check file changes when focus returns to neovim
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  command = 'checktime',
})
