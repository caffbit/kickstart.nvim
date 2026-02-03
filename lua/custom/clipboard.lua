-- lua/config/clipboard.lua
--
-- Cross-platform clipboard configuration - Auto-detect and configure clipboard tools
--
-- Usage:
--
-- 1. macOS native
--    Auto-detected, no configuration needed
--
-- 2. Windows native
--    Auto-detected, no configuration needed
--
-- 3. WSL2
--    Option A (Recommended) - Add to PATH:
--      export PATH="/mnt/c/tools/neovim/bin:$PATH"
--    Option B - Environment variable:
--      export WIN32YANK_PATH="/mnt/c/tools/neovim/bin/win32yank.exe"
--
-- 4. macOS devcontainer
--    Option A (Recommended) - Mount into container (.devcontainer/devcontainer.json):
--      {
--        "mounts": [
--          "source=/usr/bin/pbcopy,target=/usr/local/bin/pbcopy,type=bind,readonly",
--          "source=/usr/bin/pbpaste,target=/usr/local/bin/pbpaste,type=bind,readonly"
--        ]
--      }
--    Option B - Environment variables:
--      export PBCOPY_PATH="/host/usr/bin/pbcopy"
--      export PBPASTE_PATH="/host/usr/bin/pbpaste"
--
-- 5. Linux devcontainer
--    Install xclip:
--      apt-get install -y xclip

local M = {}

function M.setup()
  local function get_clipboard_provider()
    -- Detect WSL2 environment
    local is_wsl = vim.fn.filereadable('/proc/sys/fs/binfmt_misc/WSLInterop') == 1
      or vim.fn.exists('$WSL_DISTRO_NAME') == 1
      or vim.fn.exists('$WSLENV') == 1

    -- macOS native
    if vim.fn.has('macunix') == 1 then
      return {
        name = 'pbcopy',
        copy = { ['+'] = 'pbcopy', ['*'] = 'pbcopy' },
        paste = { ['+'] = 'pbpaste', ['*'] = 'pbpaste' },
      }
    end

    -- macOS devcontainer (via mount or PATH)
    if vim.fn.executable('pbcopy') == 1 and vim.fn.executable('pbpaste') == 1 then
      return {
        name = 'pbcopy',
        copy = { ['+'] = 'pbcopy', ['*'] = 'pbcopy' },
        paste = { ['+'] = 'pbpaste', ['*'] = 'pbpaste' },
      }
    end

    -- macOS devcontainer fallback (environment variables)
    local pbcopy_path = vim.env.PBCOPY_PATH
    local pbpaste_path = vim.env.PBPASTE_PATH
    if pbcopy_path and pbpaste_path 
       and vim.fn.filereadable(pbcopy_path) == 1 
       and vim.fn.filereadable(pbpaste_path) == 1 then
      return {
        name = 'pbcopy',
        copy = { ['+'] = pbcopy_path, ['*'] = pbcopy_path },
        paste = { ['+'] = pbpaste_path, ['*'] = pbpaste_path },
      }
    end

    -- Windows native
    if vim.fn.has('win32') == 1 then
      return {
        name = 'win32yank',
        copy = { ['+'] = 'win32yank.exe -i --crlf', ['*'] = 'win32yank.exe -i --crlf' },
        paste = { ['+'] = 'win32yank.exe -o --lf', ['*'] = 'win32yank.exe -o --lf' },
      }
    end

    -- WSL2 (prioritize win32yank.exe in PATH)
    if is_wsl then
      if vim.fn.executable('win32yank.exe') == 1 then
        return {
          name = 'win32yank',
          copy = { ['+'] = 'win32yank.exe -i --crlf', ['*'] = 'win32yank.exe -i --crlf' },
          paste = { ['+'] = 'win32yank.exe -o --lf', ['*'] = 'win32yank.exe -o --lf' },
        }
      end
      -- WSL2 fallback (environment variable or default path)
      local win32yank_path = vim.env.WIN32YANK_PATH or '/mnt/c/tools/neovim/bin/win32yank.exe'
      if vim.fn.filereadable(win32yank_path) == 1 then
        return {
          name = 'win32yank',
          copy = { ['+'] = win32yank_path .. ' -i --crlf', ['*'] = win32yank_path .. ' -i --crlf' },
          paste = { ['+'] = win32yank_path .. ' -o --lf', ['*'] = win32yank_path .. ' -o --lf' },
        }
      end
    end

    -- Linux (using xclip)
    if vim.fn.executable('xclip') == 1 then
      return {
        name = 'xclip',
        copy = { ['+'] = 'xclip -selection clipboard', ['*'] = 'xclip -selection primary' },
        paste = { ['+'] = 'xclip -selection clipboard -o', ['*'] = 'xclip -selection primary -o' },
      }
    end

    return nil
  end

  -- Set clipboard provider
  local provider = get_clipboard_provider()
  
  if provider then
    vim.g.clipboard = provider
  else
    vim.notify('Clipboard tool not found', vim.log.levels.WARN)
  end

  -- Enable system clipboard sync (make y/p use system clipboard directly)
  vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
  end)
end

return M