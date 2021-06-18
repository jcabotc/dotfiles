set nocompatible
filetype indent plugin on
syntax on

" Better command line completion
set wildmenu

" ======== Style ========

" Colorschemes
" - jellybeans
" - solarized8
" - apprentice
" - one (light and dark backgrounds)

" List of colorschemes to rotate between
let g:colorschemes = [
\  ['gruvbox', 'dark'],
\  ['one', 'light']
\]

" Set first colorscheme on startup
let [scheme, bg] = colorschemes[0]
execute 'colorscheme ' . scheme
execute 'set background=' . bg

" Font
set guifont=Menlo\ Regular:h15

" Full screen (Macvim only)
" set fullscreen

" Remove GUI toolbars, scrollbars, and split fill chars
set fillchars=
set guioptions-=T
set guioptions-=r
set guioptions-=L
" Hide end of buffer symbols by painting them with background color
" Current background color: `:echo synIDattr(hlID('Normal'), 'bg')`
hi EndOfBuffer ctermfg=235

" Highlight current line number only
" Current background color: `:echo synIDattr(hlID('Normal'), 'bg')`
set cursorline
hi CursorLine ctermbg=235
hi CursorLineNR ctermbg=235 ctermfg=251

" Disable beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Treat json as jsonc
augroup JsonToJsonc
    autocmd! FileType json set filetype=jsonc
augroup END

" ======== Buffer ========

" Style
set nu
set nowrap
set scrolloff=4 " Prevent cursor from reaching screen limits
set showmatch   " Matching brackets
set re=0        " Don't use legacy regular expressions engine (too slow for syntax highlighting)

" Identation (language-specific detail in filetype configs)
set tabstop=2
set shiftwidth=2
set shiftround
set autoindent
set smarttab
set expandtab
let g:indentLine_enabled = 0
let g:indentLine_char_list = ['|', '┆']

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

" Autocomplete
set updatetime=750 " Time to trigger popups (default 4000)
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-prettier', 'coc-highlight', 'coc-pairs']

function! s:check_back_space() abort " Use tab to autocomplete
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

hi CocUnderline gui=underline cterm=underline term=underline
hi CocErrorHighlight gui=underline cterm=underline term=underline
hi CocWarningHighlight gui=underline cterm=underline term=underline
hi CocInfoHighlight gui=underline cterm=underline term=underline

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

" When using :Ag, search only in file contents, not in file paths
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" ======== Filesystem ========

" Turn of backups
set nobackup
set noswapfile

" Autoread changed files
set autoread

" Autosave files (disabled to trigger less Coc events)
" let g:auto_save=1
" let g:auto_save_silent=1

" ======== Status bar ========

" Don't show empty sections, and beautiful separators
let g:airline_skip_empty_sections = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Shorten mode names
let g:airline_mode_map = {
    \ '__'     : '-',
    \ 'c'      : 'C',
    \ 'i'      : 'I',
    \ 'ic'     : 'I',
    \ 'ix'     : 'I',
    \ 'n'      : 'N',
    \ 'multi'  : 'M',
    \ 'ni'     : 'N',
    \ 'no'     : 'N',
    \ 'R'      : 'R',
    \ 'Rv'     : 'R',
    \ 's'      : 'S',
    \ 'S'      : 'S',
    \ ''     : 'S',
    \ 't'      : 'T',
    \ 'v'      : 'V',
    \ 'V'      : 'V',
    \ ''     : 'V',
    \ }

" Remove git branch symbol
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
" Disable coc info
let g:airline#extensions#coc#enabled = 0
" Empty encoding section
let g:airline_section_y=''
" Empty position section
let g:airline_section_z=''
" Empty nerdtree status line
let g:NERDTreeStatusline=''
