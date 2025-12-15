local telescope_builtin = require('telescope.builtin')
local M = {}

local function hightlight_line()
  vim.defer_fn(function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local ns_id = vim.api.nvim_create_namespace('definition_highlight')
    vim.api.nvim_buf_add_highlight(0, ns_id, 'Search', line - 1, 0, -1)
    vim.defer_fn(function()
      vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
    end, 500)
  end, 100)
end

M.setup_lsp_telescope = function()
  vim.keymap.set('n', '<leader>u', function()
    telescope_builtin.lsp_references()
    hightlight_line()
  end, { desc = 'Find usage' })

  vim.keymap.set('n', '<leader>d', function()
    telescope_builtin.lsp_definitions()
    hightlight_line()
  end, { desc = 'Go to definition' })

  vim.keymap.set('n', '<leader>i', function()
    telescope_builtin.lsp_implementations()
  end, { desc = 'Go to implementation' })

  vim.keymap.set('n', '<leader>lt', function()
    telescope_builtin.lsp_type_definitions()
    hightlight_line()
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
