local M = {}

local function pad_message(lines, opts)
    opts = opts or {}
    local pad_h = opts.horizontal or 2 -- spaces left/right
    local pad_v = opts.vertical or 1   -- blank lines top/bottom

    -- Find the longest line
    local maxlen = 0
    for _, line in ipairs(lines) do
        if #line > maxlen then maxlen = #line end
    end

    -- Pad each line with spaces left and right
    local padded = {}
    for _, line in ipairs(lines) do
        local total_pad = maxlen - #line
        local right_pad = string.rep(" ", total_pad)
        table.insert(padded, string.rep(" ", pad_h) .. line .. right_pad .. string.rep(" ", pad_h))
    end

    -- Add vertical padding (blank lines)
    for i = 1, pad_v do
        table.insert(padded, 1, string.rep(" ", maxlen + pad_h * 2))
        table.insert(padded, string.rep(" ", maxlen + pad_h * 2))
    end

    return padded, maxlen + pad_h * 2
end

function M.close_buffer_with_float()
    local buf = vim.api.nvim_get_current_buf()
    local modified = vim.bo[buf].modified

    if not modified then
        vim.cmd('bdelete')
        return
    end

    -- Create a scratch buffer for the float
    local message = {
        "Buffer is modified!",
        "Close anyway? (y/n)",
    }

    local padded_message, width = pad_message(message, { horizontal = 3, vertical = 1 })
    local height = #padded_message
    local row = math.floor((vim.o.lines - height) / 2 - 1)
    local col = math.floor((vim.o.columns - width) / 2)

    local float_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, padded_message)

    local float_win = vim.api.nvim_open_win(float_buf, false, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = { " ", " ", " ", " ", " ", " ", " ", " " },
        -- border = 'rounded',
        focusable = false,
    })
    vim.schedule(function()
        local ok, char = pcall(vim.fn.getchar)
        if ok then
            local key = vim.fn.nr2char(char)
            if key == "y" then
                vim.api.nvim_win_close(float_win, true)
                vim.cmd('bdelete!')
            else
                vim.api.nvim_win_close(float_win, true)
            end
        else
            vim.api.nvim_win_close(float_win, true)
        end
    end)
end

return M
