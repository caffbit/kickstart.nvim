return {
  'uga-rosa/translate.nvim',
  config = function()
    require('translate').setup {
      default = {
        command = 'translate_shell',
        output = 'floating',
      },
    }
  end,
  keys = {
    { 'me', '<cmd>Translate en<cr>', mode = { 'n', 'x' }, desc = '翻譯成英文' },
    { 'mc', '<cmd>Translate zh-TW<cr>', mode = { 'n', 'x' }, desc = '翻譯成中文' },
    { 'mre', '<cmd>Translate en -output=replace<cr>', mode = { 'n', 'x' }, desc = '取代成英文' },
    { 'mrc', '<cmd>Translate zh-TW -output=replace<cr>', mode = { 'n', 'x' }, desc = '取代成中文' },
  },
}
