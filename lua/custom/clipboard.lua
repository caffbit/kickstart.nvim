local function copy_osc52(text)
  local b64 = vim.base64.encode(text)
  local osc52 = string.format('\027]52;c;%s\007', b64)
  io.stdout:write(osc52)
  io.stdout:flush()
end

vim.g.clipboard = {
  name = 'OSC52',
  copy = {
    ['+'] = function(lines)
      copy_osc52(table.concat(lines, '\n'))
    end,
    ['*'] = function(lines)
      copy_osc52(table.concat(lines, '\n'))
    end,
  },
  paste = {
    ['+'] = function()
      return vim.fn.getreg('+')
    end,
    ['*'] = function()
      return vim.fn.getreg('*')
    end,
  },
}