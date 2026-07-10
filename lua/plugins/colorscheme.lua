return {
    {
        "nickkadutskyi/jb.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("jb").setup({transparent = true})
            vim.cmd("colorscheme jb")
        end,
    }
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {
    --         style = "storm",
    --         transparent = true,
    --         styles = {
    --             sidebars = "transparent",
    --             floats = "transparent",
    --         },
    --     },
    --     config = function()
    --         vim.cmd.colorscheme("tokyonight")
    --     end
    -- },
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin-nvim",
    --     priority = 1000,
    --     opts = {
    --         transparent_background = true, -- disables setting the background color.
    --     },
    --     config = function()
    --         vim.cmd.colorscheme("catppuccin")
    --     end
    -- },

    -- {
    --     "shaunsingh/nord.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --        vim.cmd.colorscheme("nord")
    --     end
    -- },
    -- Configure LazyVim to load gruvbox
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "nord",
    --     },
    -- }
}
