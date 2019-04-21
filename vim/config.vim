set nocompatible
filetype indent plugin on
syntax on

" Better command line completion
set wildmenu

" ======== Buffer ========

" Style
set nu
set nowrap
set scrolloff=4 " Prevent cursor from reaching screen limits
set showmatch   " Matching brackets

" Identation (language-specific detail in filetype configs)
set tabstop=2
set shiftwidth=2
set shiftround
set autoindent
set smarttab
set expandtab

" Search
set hlsearch   " Highlighted
set incsearch  " Incremental
set ignorecase " Ignore case on downcased search
set smartcase  " Match case when any capital letter

" Persistent undo
silent !mkdir $HOME/.vim/tmp/undodir > /dev/null 2>&1
set undodir=$HOME/.vim/tmp/undodir
set undofile
set undolevels=1000  " Maximum number of undos
set undoreload=10000 " Maximun number of lines saved for undo

" Disable splitjoin default mappings
let g:splitjoin_split_mapping=''
let g:splitjoin_join_mapping=''

" Where to store yankring history
silent !mkdir $HOME/.vim/tmp/yankring > /dev/null 2>&1
let g:yankring_history_dir = '~/.vim/tmp/yankring'

" ======== Splits ========

" New splits right to bottom
set splitbelow
set splitright

" ======== Project tree ========

" On statup set opening directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" On startup open tree
autocmd VimEnter * NERDTree

" Remove help header (press ? for help)
let NERDTreeMinimalUI=1

" ======== Search files ========

" Full text search by regex match (using ag; requires vimproc)
let g:unite_source_grep_command="ag"
let g:unite_source_grep_default_opts="-i --nocolor --nogroup"

" ======== Filesystem ========

" Turn of backups
set nobackup
set noswapfile

" Autoread changed files
set noswapfile

" Autosave files
let g:auto_save=1
let g:auto_save_silent=1

" ======== Status bar ========

" Don't show empty sections, and beautiful separators
let g:airline_skip_empty_sections = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Empty encoding section
let g:airline_section_y=''

" Simplify current position section
let g:airline_section_z='%l:%2v'

" TODO: Improve NERDTree status
let g:NERDTreeStatusline=''

" ======== Style ========

" Colorschemes
" - jellybeans
" - solarized8
" - apprentice
colorscheme solarized8

" Font
set guifont=Menlo\ Regular:h15

" Full screen
set fullscreen

" Remove GUI toolbars, scrollbars, and split fill chars
set fillchars=""
set guioptions-=T
set guioptions-=r
set guioptions-=L

" Disable beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
