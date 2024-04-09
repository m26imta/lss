-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Load vimrc
if vim.g.vscode then
  require("vscode-neovim/config/vscode_neovim_options")
else
  local home_vimrc = vim.fn.expand(vim.fn.expand("$HOME") .. "/" .. (vim.fn.has("win32") == 1 and "_vimrc" or ".vimrc"))
  local local_vimrc = vim.fn.expand(vim.fn.stdpath("config") .. "/.vimrc")
  if vim.fn.filereadable(home_vimrc) == 1 then
    vim.cmd("source " .. home_vimrc)
    print("source " .. home_vimrc)
  elseif vim.fn.filereadable(local_vimrc) == 1 then
    vim.cmd("source " .. local_vimrc)
    print("source " .. local_vimrc)
  else
    print("failed to source vimrc")
  end
end
