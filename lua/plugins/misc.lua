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
  {
    -- It enhances some builtin textobjects (like a(, a), a', and more), creates new ones (like a*, a<Space>, af, a?, and more), and allows user to create their own (like based on treesitter, and more).
    'echasnovski/mini.ai',
    version = '*',
    event = 'VeryLazy'
  },
  {
    -- bg.nvim automatically syncs terminal background and cursor with any neovim colorscheme.
    "typicode/bg.nvim",
    lazy = false
  }
}
