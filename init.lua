require 'core.options'
require 'core.autocmds'
require 'core.keymaps'
require 'core.lsp'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end


local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- 1. LazyVim core plugins (should be first)
    -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- 2. LazyVim extras (if you want any)
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.coding.copilot" },
    -- 3. Your own plugins (should be last)
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },

  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
