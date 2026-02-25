local telescope_builtin = require('telescope.builtin')
local M = {}

local highlight_ns_id = vim.api.nvim_create_namespace('definition_highlight')

local function hightlight_and_fix_pos()
  local prev_win_line = vim.fn.winline()
  local start_buf = vim.api.nvim_get_current_buf()

  local temp_augroup = vim.api.nvim_create_augroup("TempJumpFix", { clear = true })

  vim.api.nvim_create_autocmd('BufWinEnter', {
    group = temp_augroup,
    once = true,
    callback = function()
      local new_buf = vim.api.nvim_get_current_buf()

      vim.api.nvim_create_autocmd('CursorMoved', {
        group = temp_augroup,
        once = true,
        callback = function()
          vim.api.nvim_del_augroup_by_id(temp_augroup)
          if new_buf ~= start_buf then
            -- move window pos
            local cursor_pos = unpack(vim.api.nvim_win_get_cursor(0))
            local new_top_line = cursor_pos - prev_win_line + 1
            if new_top_line > 0 then
              vim.fn.winrestview({ topline = new_top_line })
            end
          end

          local cursor_row, cursor_column = unpack(vim.api.nvim_win_get_cursor(0))
          print("add hl " .. cursor_row .. " col "..cursor_column)
          vim.api.nvim_buf_add_highlight(0, highlight_ns_id, 'Search', cursor_row - 1, cursor_column, -1)
          vim.defer_fn(function()
            vim.api.nvim_buf_clear_namespace(0, highlight_ns_id, 0, -1)
          end, 500)
        end
      })
    end,
  })
end

M.setup_lsp_telescope = function()
  vim.keymap.set('n', '<leader>u', function()
    hightlight_and_fix_pos()
    telescope_builtin.lsp_references()
  end, { desc = 'Find usage' })

  vim.keymap.set('n', '<leader>d', function()
    hightlight_and_fix_pos()
    telescope_builtin.lsp_definitions()
  end, { desc = 'Go to definition' })

  vim.keymap.set('n', '<leader>i', function()
    hightlight_and_fix_pos()
    telescope_builtin.lsp_implementations()
  end, { desc = 'Go to implementation' })

  vim.keymap.set('n', '<leader>lt', function()
    hightlight_and_fix_pos()
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
