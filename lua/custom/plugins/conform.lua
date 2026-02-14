return {
    {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        -- Web Development
        javascript = { 'eslint_d', 'prettierd' },
        typescript = { 'eslint_d', 'prettierd' },
        javascriptreact = { 'eslint_d', 'prettierd' },
        typescriptreact = { 'eslint_d', 'prettierd' },
        html = { 'prettierd' },
        css = { 'prettierd' },
        scss = { 'prettierd' },
        json = { 'prettierd' },
        yaml = { 'prettierd' },
        markdown = { 'prettierd' },
        
        -- Python
        python = { 'isort', 'black' },
        
        -- Lua
        lua = { 'stylua' },
        
        -- Go
        go = { 'gofmt', 'goimports' },
        
        -- Rust
        rust = { 'rustfmt' },
        
        -- Shell
        sh = { 'shfmt' },
        bash = { 'shfmt' },
      },
    },
  }
}