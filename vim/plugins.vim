set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" Libs
Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Project tree and finding files
Plug 'scrooloose/nerdtree'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' "Requires bat for syntax highlighting: `sudo apt install bat`

" Git
Plug 'tpope/vim-fugitive'

" Status bar
Plug 'bling/vim-airline'

" Auto save files
Plug '907th/vim-auto-save'

" Colorschemes & Style
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'yggdroot/indentline'

" Text objects
Plug 'fvictorio/vim-textobj-backticks' " i` a`
Plug 'glts/vim-textobj-comment'        " ic ac
Plug 'kana/vim-textobj-entire'         " ie ae

" New commands
Plug 'vim-scripts/YankRing.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish' " word coercions
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-endwise'

" Autocomplete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Language specific: Json
Plug 'neoclide/jsonc.vim'

" Language specific: Typescript
Plug 'tasn/vim-tsx'

" Language specific: elixir
" Plug 'elixir-editors/vim-elixir'
" Plug 'mhinz/vim-mix-format'

" Language specific: haskell
" Plug 'dense-analysis/ale'
" Plug 'eagletmt/ghcmod-vim'

call plug#end()
