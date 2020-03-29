set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Libs
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-repeat'
Plugin 'kana/vim-textobj-user'
Plugin 'Shougo/vimproc.vim' " run 'make' on vimproc directory

" Project tree and finding files
Plugin 'scrooloose/nerdtree'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'

" Git
Plugin 'tpope/vim-fugitive'

" Status bar
Plugin 'bling/vim-airline'

" Auto save files
Plugin '907th/vim-auto-save'

" Colorschemes
Plugin 'lifepillar/vim-solarized8'
Plugin 'morhetz/gruvbox'
Plugin 'rakr/vim-one'

" Text objects
Plugin 'fvictorio/vim-textobj-backticks' " i` a`
Plugin 'glts/vim-textobj-comment'        " ic ac
Plugin 'kana/vim-textobj-entire'         " ie ae

" New commands
Plugin 'vim-scripts/YankRing.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish' " word coercions
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'tpope/vim-commentary'
Plugin 'mg979/vim-visual-multi'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-endwise'

" Language specific: elixir
Plugin 'elixir-editors/vim-elixir'
Plugin 'mhinz/vim-mix-format'

" Language specific: haskell
" Plugin 'dense-analysis/ale'
Plugin 'eagletmt/ghcmod-vim'

" TODO: Try the following plugins:
" https://github.com/neoclide/coc.nvim (autocomplete with elixir-ls)
" https://github.com/liuchengxu/vista.vim (current file symbols)

call vundle#end()
