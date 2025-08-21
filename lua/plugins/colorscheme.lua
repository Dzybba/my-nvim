-- Configure Nord theme settings
vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false
-- End of configure Nord theme

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = { style = "moon" },
        config = function()
            vim.cmd.colorscheme("tokyonight")
        end
    },
    {
        "shaunsingh/nord.nvim",
        lazy = false,
        priority = 1000,
        --config = function()
        --    vim.cmd.colorscheme("nord")
        --end
    },
     -- Configure LazyVim to load gruvbox
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "nord",
    --     },
    -- }
}
