local M = {}

local defaults = {
  column_limit = 80,
  highlight_group = 'ErrorMsg',
  toggle_key = '<leader>l',
  default_on = true,
  exclude_filetypes = {
    markdown = true,
    text = true,
    help = true,
  }
}

function M.setup(opts)
  -- merge user options with defaults
  local config = vim.tbl_deep_extend("force", defaults, opts or {})

  -- dynamically build regex based on the configured column limit
  local match_pattern = '\\%>' .. config.column_limit .. 'v.\\+'
  local oversize_group = vim.api.nvim_create_augroup('RoadTrainPlugin', { clear = true })

  -- set up autocommands if default_on is true
  if config.default_on then
    vim.api.nvim_create_autocmd({'WinEnter', 'BufWinEnter', 'FileType'}, {
      group = oversize_group,
      callback = function()
        if config.exclude_filetypes[vim.bo.filetype] then
          if vim.w.oversize_match_id then
            pcall(vim.fn.matchdelete, vim.w.oversize_match_id)
            vim.w.oversize_match_id = nil
          end
          return
        end

        if not vim.w.oversize_match_id and not vim.w.oversize_off then
          vim.w.oversize_match_id = vim.fn.matchadd(config.highlight_group, match_pattern)
        end
      end,
    })
  end

  -- set up toggle keymap
  if config.toggle_key then
    vim.keymap.set('n', config.toggle_key, function()
      if vim.w.oversize_match_id then
        vim.fn.matchdelete(vim.w.oversize_match_id)
        vim.w.oversize_match_id = nil
        vim.w.oversize_off = true
        print("Oversize line highlight: OFF")
      else
        vim.w.oversize_match_id = vim.fn.matchadd(config.highlight_group, match_pattern)
        vim.w.oversize_off = false
        print("Oversize line highlight: ON")
      end
    end, { desc = "Toggle oversize line highlight" })
  end
end

return M
