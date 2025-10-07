vim.lsp.enable({ 'lsp_lua', 'kotlin_lsp', 'gopls' })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf
    -- Set up completion if supported
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.opt.completeopt = { 'menu', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf)
      -- Ctrl+Space for manual completion (Android Studio default)
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end, { buffer = bufnr, desc = 'Trigger completion' })
    end

    local opts = { buffer = bufnr, silent = true }

    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))

    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
      vim.tbl_extend('force', opts, { desc = 'Go to implementation' }))
    vim.keymap.set('n', '<C-h>', vim.lsp.buf.type_definition,
      vim.tbl_extend('force', opts, { desc = 'Go to type definition' }))

    local telescope_refs = require('config.telescope.lspfindusage')
    vim.keymap.set(
      'n',
      '<leader>u',
      function()
        vim.lsp.buf.references(nil, {
          on_list = telescope_refs.find_new_ref
        })
      end, { buffer = bufnr, desc = 'Test ref' }
    )



    -- Quick documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover,
      vim.tbl_extend('force', opts, { desc = 'Show documentation' }))

    vim.keymap.set({ 'n', 'i' }, '<C-p>', vim.lsp.buf.signature_help,
      vim.tbl_extend('force', opts, { desc = 'Parameter info' }))

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename symbol' }))

    -- Code actions (Alt+Enter in Android Studio)
    vim.keymap.set({ 'n', 'v' }, '<M-CR>', vim.lsp.buf.code_action,
      vim.tbl_extend('force', opts, { desc = 'Code actions' }))
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,
      vim.tbl_extend('force', opts, { desc = 'Code actions' }))

    -- Formatting (Ctrl+Alt+L in Android Studio)
    vim.keymap.set({ 'n', 'i', 'v' }, '<C-M-l>', function()
      vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend('force', opts, { desc = 'Format code' }))

    -- Diagnostics navigation (like Android Studio's error navigation)
    vim.keymap.set('n', '<F8>', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next error/warning' }))
    vim.keymap.set('n', '<S-F8>', vim.diagnostic.goto_prev,
      vim.tbl_extend('force', opts, { desc = 'Previous error/warning' }))
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next diagnostic' }))
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Previous diagnostic' }))

    -- Show diagnostics (like Android Studio's error tooltip)
    -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
    --   vim.tbl_extend('force', opts, { desc = 'Show diagnostics' }))
    -- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
    --   vim.tbl_extend('force', opts, { desc = 'Diagnostics to quickfix' }))

    -- Workspace management
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
      vim.tbl_extend('force', opts, { desc = 'Add workspace folder' }))
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
      vim.tbl_extend('force', opts, { desc = 'Remove workspace folder' }))
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend('force', opts, { desc = 'List workspace folders' }))

    -- Additional useful mappings
    -- Ctrl+Shift+I for inline hints (similar to Android Studio's inline hints)
    if client.server_capabilities.inlayHintProvider then
      vim.keymap.set('n', '<C-S-i>', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, vim.tbl_extend('force', opts, { desc = 'Toggle inlay hints' }))
    end
  end,
})

vim.api.nvim_create_user_command("LspCaps", function()
  local client = vim.lsp.get_active_clients({ bufnr = 0 })[1]
  if not client then
    print("No LSP client attached")
    return
  end

  local caps = vim.inspect(client.server_capabilities)

  -- create scratch buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "filetype", "lua")

  -- split window and show buffer
  vim.cmd("vsplit")
  vim.api.nvim_win_set_buf(0, buf)

  -- write capabilities into buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(caps, "\n"))
end, {})
