-- Standalone plugins with less than 10 lines of config go here
return {
 -- {
 --   -- Tmux & split window navigation
 --   'christoomey/vim-tmux-navigator',
 -- },
  {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    event = 'VeryLazy'
  },
  {
    -- Hints keybinds
    'folke/which-key.nvim',
    event = 'VeryLazy'
  },
  {
    -- Autoclose parentheses, brackets, quotes, etc.
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
--  {
--    'echasnovski/mini.animate',
--    version = '*',
--    event = "VeryLazy",
--    config = function ()
--      require('mini.animate').setup({
--        cursor = {
--          enable = false,
--        }
--      })
--    end
--  },
}
