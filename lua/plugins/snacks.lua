return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    explorer = {
      win = {
        list = {
          keys = {
            ["<BS>"] = "explorer_up",
            ["l"] = "confirm",
            ["h"] = "explorer_close", -- close directory
            ["a"] = "explorer_add",
            ["d"] = "explorer_del",
            ["r"] = "explorer_rename",
            ["c"] = "explorer_copy",
            ["m"] = "explorer_move",
            ["o"] = "explorer_open", -- open with system application
            ["P"] = "toggle_preview",
            ["y"] = { "explorer_yank", mode = { "n", "x" } },
            ["p"] = "explorer_paste",
            ["u"] = "explorer_update",
            ["<c-c>"] = "tcd",
            ["<leader>/"] = "picker_grep",
            ["<c-t>"] = "terminal",
            ["."] = "explorer_focus",
            ["I"] = "toggle_ignored",
            ["H"] = "toggle_hidden",
            ["Z"] = "explorer_close_all",
            ["]g"] = "explorer_git_next",
            ["[g"] = "explorer_git_prev",
            ["]d"] = "explorer_diagnostic_next",
            ["[d"] = "explorer_diagnostic_prev",
            ["]w"] = "explorer_warn_next",
            ["[w"] = "explorer_warn_prev",
            ["]e"] = "explorer_error_next",
            ["[e"] = "explorer_error_prev",
          },
        },
      },
    },
    dashboard = {
      sections = {
        { section = "header" },
        --{
        --  pane = 2,
        --  section = "terminal",
        --  cmd = "colorscript -e square",
        --  height = 5,
        --  padding = 1,
        --},
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
    lazygit = {
      -- your lazygit configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  keys = {
    { "<leader>e", function() Snacks.explorer() end, desc = "Explorer" },
    { "<leader>lg", function() Snacks.lazygit() end, desc = "LazyGit" },
  },
}
