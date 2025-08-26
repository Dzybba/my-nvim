-- Format JSON with jq
vim.api.nvim_create_user_command('FormatJSON', function(opts)
  if vim.fn.executable('jq') == 1 then
    if opts.range > 0 then
      -- Format selected lines
      vim.cmd(string.format('%d,%d!jq .', opts.line1, opts.line2))
    else
      -- Format entire buffer
      vim.cmd('%!jq .')
    end
  else
    vim.notify("jq not installed", vim.log.levels.ERROR)
  end
end, { range = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Hightlight when yankin',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
