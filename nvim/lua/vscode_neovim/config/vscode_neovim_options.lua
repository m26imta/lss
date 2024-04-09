-- vscode-neovim  -  VSCode Neovim Integration
-- https://github.com/vscode-neovim/vscode-neovim

vim.cmd([[
""
let mapleader = " "
let maplocalleader = "\\"

"" Options
set timeoutlen=400
let g:clipboard = g:vscode_clipboard
set iskeyword+=- backspace=indent,eol,start
set nolist listchars=tab:→\ ,nbsp:␣,trail:•,space:⋅,extends:▶,precedes:◀,eol:↴


"" Keymaps
"" Indent
nnoremap < v<
nnoremap > v>
vnoremap < <gv
vnoremap > >gv
vnoremap <S-h> <gv
vnoremap <S-l> >gv

"" Move lines up & down
vnoremap <S-j> :m '>+1<cr>gv=gv
vnoremap <S-k> :m '<-2<cr>gv=gv

"" Ctrl+A to select all
nnoremap <C-a> maggVG

]])
