-- Set <leader> to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', { silent = true, desc = "Disable space in normal and visual mode" })

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy selection to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+yg_', { desc = "Copy from cursor to end of line to system clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy motion to system clipboard" })
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "Copy entire line to system clipboard" })

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard after cursor" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from system clipboard before cursor" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Replace selection with system clipboard" })
vim.keymap.set("v", "<leader>P", '"+P', { desc = "Paste from system clipboard before selection" })

-- Paste in insert mode from default register
vim.keymap.set("i", "<C-p>", '<C-r>"', { desc = "Paste from default register in insert mode" })

-- Clear search on <Esc>
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR><Esc>", { desc = "Clear search highlights" })

-- Redo
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Don't use Ex mode, use Q for formatting (gq)
vim.keymap.set("n", "Q", "gq", { desc = "Format text using gq" })

-- Format Json string 
vim.keymap.set('n', '<leader>jf', ':FormatJSON<CR>', { desc = 'Format buffer as JSON' })
vim.keymap.set('v', '<leader>jf', ':FormatJSON<CR>', { desc = 'Format selected JSON' })
 
local opts = { noremap = true, silent = true }

-- Prevent copy to buffer when click x
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true, desc = "Delete character without copying to register" })

-- Resize with arrows
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { noremap = true, silent = true, desc = "Decrease window height" })
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { noremap = true, silent = true, desc = "Increase window height" })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true, desc = "Decrease window width" })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true, desc = "Increase window width" })

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true, desc = "Go to next buffer" })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true, desc = "Go to previous buffer" })
vim.keymap.set('n', '<leader>bn', '<cmd> enew <CR>', { noremap = true, silent = true, desc = "Create new buffer" })

-- Smart close with confirmation for unsaved buffers
vim.keymap.set('n', '<M-x>', function()
  local buf = vim.api.nvim_get_current_buf()
  local modified = vim.bo[buf].modified
  
  if modified then
    vim.cmd('confirm bdelete')
  else
    vim.cmd('bdelete')
  end
end, { noremap = true, silent = true, desc = "Close buffer" })


vim.keymap.set('n', '<leader>x', function()
  -- Count windows excluding explorer
  local window_count = vim.fn.winnr('$')
  print("window count:", window_count)
  if window_count > 1 then
    vim.cmd('close')
  end
end, { noremap = true, silent = true, desc = "Close split window" })

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', { noremap = true, silent = true, desc = "Split window vertically" })
vim.keymap.set('n', '<leader>h', '<C-w>s', { noremap = true, silent = true, desc = "Split window horizontally" })
vim.keymap.set('n', '<leader>se', '<C-w>=', { noremap = true, silent = true, desc = "Make split windows equal size" })

-- Navigate between splits
vim.keymap.set('n', '<A-Tab>', '<C-w>w', { noremap = true, silent = true, desc = "Cycle through windows" })
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true, desc = "Move to window above" })
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true, desc = "Move to window below" })
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true, desc = "Move to window left" })
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true, desc = "Move to window right" })

-- Tabs
--vim.keymap.set('n', '<leader>to', ':tabnew<CR>', { noremap = true, silent = true, desc = "Open new tab" })
--vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { noremap = true, silent = true, desc = "Close current tab" })
--vim.keymap.set('n', '<leader>tn', ':tabn<CR>', { noremap = true, silent = true, desc = "Go to next tab" })
--vim.keymap.set('n', '<leader>tp', ':tabp<CR>', { noremap = true, silent = true, desc = "Go to previous tab" })

-- Toggle line wrapping
-- vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', { noremap = true, silent = true, desc = "Toggle line wrapping" })

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true, desc = "Indent left and reselect" })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true, desc = "Indent right and reselect" })

local function auto_quote()
  local mode = vim.fn.mode()
  
  -- Check if in any visual mode
  if mode == 'v' then
    -- Store what we're about to replace
    vim.cmd('normal! c""')
    -- Enter insert mode, add closing quote, exit, paste content
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>P', true, false, true), 'n', true)
  end
end

-- Keybinding: Press " to auto-add quotes
vim.keymap.set('v', '"', auto_quote, {
  noremap = true,
  silent = true,
  desc = 'Add quotes around word/selection'
})

vim.keymap.set({ "n", "i", "v" }, "<M-s>", "<cmd>w<cr>", { noremap = true, silent = true })

-- Diagnostic keymaps (commented out)
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
