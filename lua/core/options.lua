 -- Show numbers 
vim.o.number = true
vim.o.relativenumber = true

vim.o.expandtab = true     -- convert tabs to spaces
vim.o.tabstop = 4          -- a tab is shown as 4 spaces
vim.o.softtabstop = 4      -- pressing Tab inserts 4 spaces
vim.o.shiftwidth = 4       -- auto-indent uses 4 spaces

vim.o.termguicolors = true

-- Show a few lines of context around the cursor
vim.opt.scrolloff = 5

-- Incremental search, highlight search, ignore case, smart case
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.autoindent = true

-- Use system clipboard
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

