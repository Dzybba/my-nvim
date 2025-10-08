local telescope_builtin = require('telescope.builtin')
local M = {}

M.setup_lsp_telescope = function()
    vim.keymap.set('n', '<leader>u', function()
      telescope_builtin.lsp_references()
    end, { desc = 'Find usage' })

    vim.keymap.set('n', '<leader>d', function()
      telescope_builtin.lsp_definitions()
    end, { desc = 'Go to definition' })

    vim.keymap.set('n', '<leader>i', function()
      telescope_builtin.lsp_implementations()
    end, { desc = 'Go to implementation' })

    vim.keymap.set('n', '<leader>lt', function()
      telescope_builtin.lsp_type_definitions()
    end, { desc = 'Go to type definition' })

    vim.keymap.set('n', '<leader>ls', function()
      telescope_builtin.lsp_document_symbols()
    end, { desc = 'Show document symbols' })

    vim.keymap.set('n', '<leader>lw', function()
      telescope_builtin.lsp_workspace_symbols()
    end, { desc = 'Show workspace symbols' })
  
    vim.keymap.set('n', '<leader>lci', function()
      telescope_builtin.lsp_incoming_calls()
    end, { desc = 'Show incoming calls' })

    vim.keymap.set('n', '<leader>lco', function()
      telescope_builtin.lsp_outgoing_calls()
    end, { desc = 'Show outgoing calls' })
end

-- todo add typehierarchy({kind})                            *vim.lsp.buf.typehierarchy()*


return M
