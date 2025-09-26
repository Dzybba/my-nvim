local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local utils = require "telescope.utils"

local M = {}

local tel_find_ref = function(opts)
    opts = opts or {}

    -- Get current buffer and cursor position
    local bufnr = vim.api.nvim_get_current_buf()
    local params = vim.lsp.util.make_position_params()

    -- Add the required context for references request
    params.context = {
        includeDeclaration = true
    }

    -- Request references from LSP
    vim.lsp.buf_request(bufnr, 'textDocument/references', params, function(err, result, ctx, config)
        if err then
            vim.notify("Error getting references: " .. err.message, vim.log.levels.ERROR)
            return
        end

        if not result or vim.tbl_isempty(result) then
            vim.notify("No references found", vim.log.levels.INFO)
            return
        end

        -- Convert LSP locations to telescope entries
        local entries = {}
        for _, ref in ipairs(result) do
            local uri = ref.uri
            local range = ref.range
            local filename = vim.uri_to_fname(uri)
            local lnum = range.start.line + 1
            local col = range.start.character + 1

            -- Read the line content
            local line_content = ""
            if vim.fn.filereadable(filename) == 1 then
                local lines = vim.fn.readfile(filename, "", lnum)
                if #lines > 0 then
                    line_content = lines[lnum] or ""
                end
            end

            table.insert(entries, {
                value = ref,
                display = string.format("%s:%d:%d: %s",
                    vim.fn.fnamemodify(filename, ":t"),
                    lnum,
                    col,
                    vim.trim(line_content)),
                ordinal = filename .. " " .. line_content,
                filename = filename,
                lnum = lnum,
                col = col,
            })
        end

        pickers.new(opts, {
            prompt_title = "LSP References",
            finder = finders.new_table {
                results = entries,
                entry_maker = function(entry)
                    return entry
                end,
            },
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local entry = action_state.get_selected_entry()
                    if entry then
                        vim.cmd("edit " .. entry.filename)
                        vim.api.nvim_win_set_cursor(0, { entry.lnum, entry.col - 1 })
                    end
                end)
                return true
            end,
            previewer = conf.grep_previewer(opts),
        }):find()
    end)
end

M.find_references = tel_find_ref

M.setup = function(opts)
    opts = opts or {}

    -- Optional: Create a command
    vim.api.nvim_create_user_command('TelescopeReferences', function()
        tel_find_ref()
    end, {})

    -- Optional: Set up keymapping
    if opts.keymaps then
        vim.keymap.set('n', opts.keymaps.references or '<leader>gr', tel_find_ref,
            { desc = 'Find references with Telescope' })
    end
end

return M
