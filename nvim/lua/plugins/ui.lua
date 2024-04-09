return {
  --
  -- bbye
  {
    "moll/vim-bbye",
    cmd = { "Bdelete" },
    keys = {
      { "<S-x>", "<cmd>Bdelete!<cr>", desc = "Close current buffer", mode = { "n" }, noremap = true, silent = true },
      -- { "<S-q>" },
    },
  },
  --
  -- bufferline
  -- change config of LazyVim
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    -- merge with lazyvim's config
    -- change style to underline
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        options = {
          indicator = { style = "underline", icon = "▎" },
          buffer_close_icon = "",
          modified_icon = "●",
          close_icon = "",
        },
      })
    end,
  },
  --
  -- neotree
  -- change config of LazyVim
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        window = {
          width = 30,
          mappings = {
            -- Navigation with HJKL
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#navigation-with-hjkl
            ["h"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" and node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(state, node)
              else
                require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
              end
            end,
            ["l"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" then
                if not node:is_expanded() then
                  require("neo-tree.sources.filesystem").toggle_directory(state, node)
                elseif node:has_children() then
                  require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                elseif node:is_file() then
                end
              end
            end,
            -- Open file without losing sidebar focus
            -- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Tips#open-file-without-losing-sidebar-focus
            ["<tab>"] = function(state)
              local node = state.tree:get_node()
              if require("neo-tree.utils").is_expandable(node) then
                state.commands["toggle_node"](state)
              else
                state.commands["open"](state)
                vim.cmd("Neotree reveal")
              end
            end,
          },
        },
      })
    end,
  },
  --
  -- nvim_tree
  {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
    keys = {
      { "<leader>1", "<cmd>NvimTreeToggle<cr>", silent = true },
      { "<leader>da", "<cmd>cd %:h<cr><cmd>NvimTreeOpen<cr>", silent = true },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Disable netrw
      -- vim.g.loaded_netrwPlugin = 1
      -- vim.g.loaded_netrw = 1

      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_cursor = true,
        hijack_netrw = false,
        update_cwd = true,
        view = {
          width = 30,
          side = "left",
        },
        git = {
          enable = true,
          ignore = true,
          timeout = 400,
        },
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },

        -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Archived#example
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")

          local function opts(desc)
            return {
              desc = "nvim-tree: " .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            }
          end

          -- BEGIN_DEFAULT_ON_ATTACH
          api.config.mappings.default_on_attach(bufnr) -- just single-line setup

          -- You will need to insert "your code goes here" for any mappings with a custom action_cb
          vim.keymap.set("n", "A", api.tree.expand_all, opts("Expand All"))
          vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
          vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
          vim.keymap.set("n", "P", function()
            local node = api.tree.get_node_under_cursor()
            print(node.absolute_path)
          end, opts("Print Node Path"))

          vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
          vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))

          vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
          vim.keymap.set("n", "Z", api.node.run.system, opts("Run System"))
        end,
      })
    end,
  },
}
