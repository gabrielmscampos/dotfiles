local reset_group = vim.api.nvim_create_augroup('reset_group', {
  clear = false,
})

-- ==================
--     Statusline
-- ==================
vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  desc = 'word count for the statusline',
  pattern = { '*.md', '*.txt' },
  callback = function()
    local wc = vim.fn.wordcount().words
    if wc == 0 then
      vim.b.wordcount = ''
    elseif wc == 1 then
      vim.b.wordcount = wc .. ' word'
    else
      vim.b.wordcount = wc .. ' words'
    end
  end,
  group = init_group,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'FocusGained' }, {
  desc = 'git branch and LSP errors for the statusline',
  callback = function()
    if vim.fn.isdirectory '.git' ~= 0 then
      -- always runs in the current directory, rather than in the buffer's directory
      local branch = vim.fn.system "git branch --show-current | tr -d '\n'"
      vim.b.branch_name = '  ' .. branch .. ' '
    end

    local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    -- if there are any errors only show the error count, don't include the number of warnings
    if num_errors > 0 then
      vim.b.errors = '  ' .. num_errors .. ' '
      return
    end

    -- otherwise show amount of warnings, or nothing if there aren't any
    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if num_warnings > 0 then
      vim.b.errors = '  ' .. num_warnings .. ' '
      return
    end
    vim.b.errors = ''
  end,
  group = init_group,
})

vim.opt.laststatus = 3 -- use global statusline
vim.opt.statusline =
  [[%#PmenuSel#%{get(b:, "branch_name", "")}%#LineNr# %f %m %= %#CursorColumn# %{get(b:, "errors", "")} %{get(b:, "wordcount", "")} %y %{&fileencoding?&fileencoding:&encoding} [%{&fileformat}] %p%% %l:%c]]

