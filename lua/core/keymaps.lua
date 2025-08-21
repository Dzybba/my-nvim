-- Set <leader> to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', { silent = true })

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+yg_')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+yy')

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P')

-- Paste in insert mode from default register
vim.keymap.set("i", "<C-p>", '<C-r>"')

-- Clear search on <Esc>
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR><Esc>")

-- Redo
vim.keymap.set("n", "U", "<C-r>")

-- Don't use Ex mode, use Q for formatting (gq)
vim.keymap.set("n", "Q", "gq")

-- Format Json string 
vim.keymap.set('n', '<leader>jf', ':FormatJSON<CR>', { desc = 'Format buffer as JSON' })
vim.keymap.set('v', '<leader>jf', ':FormatJSON<CR>', { desc = 'Format selected JSON' })
 

local opts = { noremap = true, silent = true }
-- Prevent copy to buffer when click x
vim.keymap.set('n', 'x', '"_x', opts)


-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
-- vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
-- vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
-- vim.keymap.set('n', '<leader>x', ':bdelete!<CR>', opts) -- close buffer
-- vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<leader>w', '<C-w>w', opts)  -- Leader + w
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
-- vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', function()
--   vim.diagnostic.jump { count = -1, float = true }
-- end, { desc = 'Go to previous diagnostic message' })
-- 
-- vim.keymap.set('n', ']d', function()
--   vim.diagnostic.jump { count = 1, float = true }
-- end, { desc = 'Go to next diagnostic message' })
-- 
-- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
