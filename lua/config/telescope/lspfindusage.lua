local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M = {}

M.find_new_ref = function(options)
    -- print(vim.inspect(options))
    pickers.new({}, {
        prompt_title = options.title,
        finder = finders.new_table {
            results = options.items,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.text,
                    ordinal = entry.text,
                    filename = entry.filename or vim.uri_to_fname(entry.uri),
                    lnum = entry.lnum,
                    col = entry.col,
                }
            end,
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd('edit ' .. entry.filename)
                vim.fn.cursor(entry.lnum, entry.col)
            end)
            return true
        end,
        previewer = conf.grep_previewer({}),
        -- preview_title = function(entry)
        --     return vim.fn.fnamemodify(entry.filename, ":t") -- just the filename
        -- end,
    }):find()
end


return M
