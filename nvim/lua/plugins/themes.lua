-- stylua: ignore start

local theme = "moonfly"
-- "name / varient" OR just "name"
-- "nightfox/carbonfox"  OR just "nightfox"

local preinstall = true    -- true: install all themes / false: install only 1 theme
local islazy = true  -- themes is lazy, so use :Lazy load foo.nvim to invoke and then use :color ... to set colorscheme

local default_theme_opts = {
  lazy = islazy,
}

local builtin_themes = {"blue", "darkblue", "default", "delek", "desert", "elflord",
  "evening", "habamax", "industry", "koehler", "lunaperche", "morning", "murphy",
  "pablo", "peachpuff", "quiet", "ron", "shine", "slate", "torte", "zellner"}

local themes = {
  { "joshdick/onedark.vim",           name = "onedark",          varients = { "onedark" } },
  { "lunarvim/darkplus.nvim",         name = "darkplus",         varients = { "darkplus" } },
  { "bluz71/vim-moonfly-colors",      name = "moonfly",          varients = { "moonfly" } },
  { "bluz71/vim-nightfly-guicolors",  name = "nightfly",         varients = { "nightfly" } },
  { "sainnhe/everforest",             name = "everforest",       varients = { "everforest" } },
  { "morhetz/gruvbox",                name = "gruvbox",          varients = { "gruvbox" } },
  { "sainnhe/gruvbox-material",       name = "gruvbox-material", varients = { "gruvbox-material" } },
  { "Mofiqul/dracula.nvim",           name = "dracula",          varients = { "dracula", "dracula-soft" } },
  { "EdenEast/nightfox.nvim",         name = "nightfox",         varients = { "nightfox", "dayfox", "dawnfox", "duskfox", "nordfox", "terafox", "carbonfox"} },
  { "folke/tokyonight.nvim",          name = "tokyonight",       varients = { "tokyonight", "tokyonight-day", "tokyonight-moon", "tokyonight-night", "tokyonight-storm" } },
  { "catppuccin/nvim",                name = "catppuccin",       varients = { "catppuccin", "catppuccin-frappe", "catppuccin-latte", "catppuccin-macchiato", "catppuccin-mocha" } },
  { "projekt0n/github-nvim-theme",    name = "github-theme",     varients = { "github_dark", "github_dark_colorblind", "github_dark_default", "github_dark_dimmed", "github_dark_high_contrast", "github_dark_tritanopia", "github_dimmed", "github_light", "github_light_colorblind", "github_light_default", "github_light_high_contrast", "github_light_tritanopia" } },
}

local t = {}
for m in theme.gmatch(theme, "[^/]+") do
  table.insert(t, m)
end
local theme_name = t[1]
local theme_varient = t[2]
local color_cmd = theme_varient == nil and theme_name or theme_varient

local function set_theme()
  for _, v in pairs(builtin_themes) do
    if v == theme_name then
      vim.cmd("color " .. theme_name)
      color_cmd = theme_name
      return {}
    end
  end

  local M = {}
  for _, v in ipairs(themes) do
    v = vim.tbl_deep_extend("force", v, default_theme_opts)   -- set default color opts for every varients
    local color_scheme = (theme_varient~=nil and (function() for _, vv in pairs(v.varients) do if vv==theme_varient then return vv end end end)()) and theme_varient or v.varients[1]
    v.color_scheme = color_scheme
    if v.name == theme_name then
      v.init = function()
        vim.cmd("color " .. color_scheme)
        color_cmd = color_scheme
      end
      v.lazy = false    -- make sure we load this during startup if it is your main varients
      v.priority = 1000 -- make sure to load this before all the other plugins start
    end
    if preinstall then
      table.insert(M, v)
    elseif v.name == theme_name then
      table.insert(M, v)
      break
    end
  end

  -- Configure LazyVim to load colorscheme
  local lazyvim_ok, _ = pcall(require, "lazyvim")
  if lazyvim_ok then
    table.insert(M, {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = color_cmd,
      },
    })
  end

  return M
end

return set_theme()
-- stylua: ignore end
