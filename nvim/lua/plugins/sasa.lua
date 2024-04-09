return {
  --
  -- telescope
  -- change config of LazyVim
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = function(_, opts)
      local actions = require("telescope.actions")
      return vim.tbl_deep_extend("force", opts, {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
          mappings = {
            i = {
              ["<C-c>"] = actions.close,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<C-c>"] = actions.close,
              ["q"] = actions.close,
            },
          },
        },
      })
    end,
  },
  --
  -- Remove & change some keymaps that conflict with my vimrc
  -- LSP keymaps : <c-k> conflict as it is a <UP> key in my vimrc
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change <c-k> -> <c-f><c-k>
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
      keys[#keys + 1] = {
        "<c-f><c-k>",
        vim.lsp.buf.signature_help,
        mode = { "n", "i" },
        desc = "Signature Help",
        has = "signatureHelp",
      }
    end,
  },
  --
  -- noice
  -- remove <c-f> as a reservation key in my vimrc, and remove also <c-b> because it is a pair with <c-f>
  {
    "folke/noice.nvim",
    -- remove <c-f>, <c-b>
    keys = function(_, keys)
      local keys_removal = { "<c-f>", "<c-b>" }
      local keys_index_removal = {}
      -- find the "<c-f>", "<c-b>" in keys table
      for index, value in ipairs(keys) do
        for _, v in ipairs(keys_removal) do
          if string.lower(value[1]) == v then
            table.insert(keys_index_removal, index)
          end
        end
      end
      -- sort index
      table.sort(keys_index_removal)
      -- remove the higher index first
      for i = #keys_index_removal, 1, -1 do
        table.remove(keys, keys_index_removal[i])
      end
      return keys
    end,
  },
}
