-- token link: https://codeium.com/account/login?redirect_uri=vim-show-auth-token&state=a&redirect_parameters_type=query
local use_codeium = true
local use_codeium_lazyvim_config_instead = false
if use_codeium then
  -- stylua: ignore start
  return use_codeium_lazyvim_config_instead
    and {
      -- use codeium.nvim
      import = "lazyvim.plugins.extras.coding.codeium"
    }
    or {
      -- use codeium.vim
      "Exafunction/codeium.vim",
      event = "BufEnter",
      config = function()
        local use_default = false
        if not use_default then
          -- disable default keybidings
          vim.g.codeium_disable_bindings = 1
          -- Change '<C-g>' here to any keycode you like.
          --vim.cmd([[imap <script><silent><nowait><expr> <C-g> codeium#Complete()]]) -- codeium#Complete()
          vim.cmd([[imap <script><silent><nowait><expr> <M-e> codeium#Accept()]])
          --
          vim.keymap.set("i", "<M-]>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
          vim.keymap.set("i", "<M-[>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
          vim.keymap.set("i", "<M-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
        end
      end,
    }
end
-- stylua: ignore end
