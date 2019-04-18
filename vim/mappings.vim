" ======== Basic ========

let mapleader=','

" ======== Manage vim config ========

nmap <leader>v [vimrc]

" Edit .vimrc and filetype configs
nnoremap <silent> [vimrc]e :edit ~/.vimrc<CR>
nnoremap <silent> [vimrc]le :edit ~/.vim/after/ftplugin<CR>
nnoremap <silent> [vimrc]s :source ~/.vimrc<CR>:nohlsearch<CR>:echo 'Vimrc sourced'<CR><ESC>

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

" Turn off search highlight on ESC
nnoremap <silent> <ESC> :nohlsearch<CR><ESC>

" Coercion (abolish plugin)
"   crc: camel_case
"   crm: MixedCase
"   crs: snake_case
"   cru: UPPER_CASE

" Set Splitjoin custom mappings
let g:splitjoin_split_mapping=''
let g:splitjoin_join_mapping=''
nmap <Leader>k :SplitjoinJoin<cr>
nmap <Leader>j :SplitjoinSplit<cr>

" TODO: Fix to properly work with text objects
" Toggle comments
xmap <leader>c <Plug>Commentary
omap <leader>c <Plug>Commentary

" Persistent undo
silent !mkdir $HOME/.vim/tmp/undodir > /dev/null 2>&1
set undodir=$HOME/.vim/tmp/undodir
set undofile
set undolevels=1000  " Maximum number of undos
set undoreload=10000 " Maximun number of lines saved for undo

" ======== Yankring ========

" Where to store yankring history
silent !mkdir $HOME/.vim/tmp/yankring > /dev/null 2>&1
let g:yankring_history_dir = '~/.vim/tmp/yankring'

" TODO: Rethink this keys
" Replace pasted text by previous or next register
let g:yankring_replace_n_pkey = 'K'
let g:yankring_replace_n_nkey = 'Q'

" ======== Multiple cursors ========

" Disable default mappings
let g:VM_default_mappings = 1
let g:VM_mouse_mappings = 1

let g:VM_maps = {}

" TODO: Rethink this mappings
" Normal mapping overrides
let g:VM_maps['Find Under'] = '<C-n>'
let g:VM_maps['Find Subword Under'] = '<C-n>'
let g:VM_maps['Select All'] = '<C-m>a'
let g:VM_maps['Visual All'] = '<C-m>a'
let g:VM_maps['Start Regex Search'] = '<C-m>r'
let g:VM_maps['Visual Regex'] = '<C-m>r'

" TODO: Rethink this mappings
" Multiple cursors mode overrides
let g:VM_maps['Switch Mode'] = 'v'
let g:VM_maps['Find Next'] = '<C-n>'
let g:VM_maps['Skip Region'] = '<C-m>'
let g:VM_maps['Remove Region'] = '<C-b>'
let g:VM_maps['Surround'] = 'S'
let g:VM_maps['Numbers Append'] = 'K'

" ======== Splits ========

" New splits to right and bottom
set splitbelow
set splitright

" Move between splits
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" ======== Project tree ========

" Toggle tree
nnoremap <leader>n :NERDTreeToggle<CR>

" Reveal current file
nnoremap <leader>cn :NERDTreeFind<CR>

" On statup set opening directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" On startup open tree
autocmd VimEnter * NERDTree

" Remove help header (press ? for help)
let NERDTreeMinimalUI=1

" ======== Search files ========

" Functions to set unite matchers
function ContextMatcher()
  call unite#filters#matcher_default#use(['matcher_context'])
endfunction

function FuzzyMatcher()
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
endfunction

function RegexMatcher()
  call unite#filters#matcher_default#use(['matcher_regexp'])
endfunction

" TODO: Ensure both exact and fuzzy match are useful
" Project files path by exact match
nnoremap <silent> <leader>ee :call ContextMatcher()<CR>:<C-u>Unite -start-insert -buffer-name=project file_rec<CR>

" Project files path by fuzzy search
nnoremap <silent> <leader>ef :call FuzzyMatcher()<CR>:<C-u>Unite -start-insert -buffer-name=project file_rec<CR>

" Recent file name by exact match
nnoremap <silent> <leader>m :call ContextMatcher()<CR>:<C-u>Unite -buffer-name=recent file_mru<cr>

" Full text search by regex match (using ag; requires vimproc)
let g:unite_source_grep_command="ag"
let g:unite_source_grep_default_opts="-i --nocolor --nogroup"
nnoremap <silent> <leader>f :call RegexMatcher()<CR>:<C-u>Unite -no-quit -buffer-name=search grep:.<cr>

" ======== Git ========

nmap <leader>g [git]

" Git status (-: stage/unstage, =: show diff)
nnoremap <silent> [git]s :Gstatus<CR>

" On the current file
nnoremap <silent> [git]b :Gblame<CR>
nnoremap <silent> [git]d :Gvdiff<CR>
nnoremap <silent> [git]r :Gread~0<CR>

" ======== Filesystem ========

" Copy current file path to system clipboard
nmap <silent> <leader>cp :let @*=expand("%")<CR>:echo 'Path copied to system clipboard'<CR>

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
colorscheme jellybeans

" Font
set guifont=Menlo\ Regular:h15

" Full screen
set fu

" Remove GUI toolbars, scrollbars, and split fill chars
set fillchars=""
set guioptions-=T
set guioptions-=r
set guioptions-=L

" Disable beeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
