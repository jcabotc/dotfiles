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

" Git
Plug 'tpope/vim-fugitive'

" Status bar
Plug 'bling/vim-airline'

" Auto save files
Plug '907th/vim-auto-save'

" Colorschemes
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'

" Text objects
" - i` a`
Plug 'fvictorio/vim-textobj-backticks'
" - ic ac
Plug 'glts/vim-textobj-comment'
" - ie ae
Plug 'kana/vim-textobj-entire'

" New commands
Plug 'vim-scripts/YankRing.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish' " word coercions
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi'
" Plug 'ervandew/supertab'
Plug 'tpope/vim-endwise'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" https://github.com/neoclide/coc.nvim (autocomplete with elixir-ls)

" Language specific: Typescript
Plug 'tasn/vim-tsx'

" Language specific: elixir
" Plug 'elixir-editors/vim-elixir'
" Plug 'mhinz/vim-mix-format'

" Language specific: haskell
" Plug 'dense-analysis/ale'
" Plug 'eagletmt/ghcmod-vim'

" TODO: Try the following plugins:
" https://github.com/liuchengxu/vista.vim (current file symbols)

call plug#end()
