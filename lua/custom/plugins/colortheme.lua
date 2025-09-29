return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'mocha',
      transparent_background = true,
      auto_integrations = true,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    lazy = false, -- Important: Don't delay loading
    config = function()
      -- For some plugins of ui, you would like to clear all highlights. At this point you should use clear_prefix
      -- require('transparent').clear_prefix('lualine')
    end,
  },
}
