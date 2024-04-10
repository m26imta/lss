local M = {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
}

M.config = function()
  local opts = {
    size = 15,
    open_mapping = [[<C-\>]],
    start_in_insert = true,
    direction = "float",
  }

  vim.cmd([[
    " set
    autocmd TermEnter term://*toggleterm#*
          \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

    " By applying the mappings this way you can pass a count to your
    " mapping to open a specific window.
    " For example: 2<C-t> will open terminal 2
    nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
  ]])

  require("toggleterm").setup(opts)

  -- stylua: ignore start
  local python_term = require("toggleterm.terminal").Terminal:new({ cmd = "python3", hidden = true, direction = "float" })
  vim.keymap.set("n", "<C-p>", function() python_term:toggle() end, { noremap = true, silent = true })

  -- stylua: ignore end
end

return M
