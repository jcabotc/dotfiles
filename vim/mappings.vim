let mapleader=','

" ======== Manage vim config ========

nmap <leader>v [vimrc]

" Edit .vimrc and filetype configs
nnoremap <silent> [vimrc]e :edit ~/.vimrc<CR>
nnoremap <silent> [vimrc]le :edit ~/.vim/after/ftplugin<CR>
nnoremap <silent> [vimrc]s :source ~/.vimrc<CR>:nohlsearch<CR>:echo 'Vimrc sourced'<CR><ESC>

" ======== Buffer ========

" Make Y act like other capitals
map Y y$

" Turn off search highlight on ESC
nnoremap <silent> <ESC> :nohlsearch<CR><ESC>

" Coercion (abolish plugin)
"   crc: camel_case
"   crm: MixedCase
"   crs: snake_case
"   cru: UPPER_CASE

" Splitjoin
nmap <Leader>k :SplitjoinJoin<cr>
nmap <Leader>j :SplitjoinSplit<cr>

" TODO: Rethink this keys
" Yankring
let g:yankring_replace_n_pkey = 'K' " previous register
let g:yankring_replace_n_nkey = 'Q' " next register

" Toggle comments
nmap <leader>c <Plug>Commentary
xmap <leader>c <Plug>Commentary
omap <leader>c <Plug>Commentary

" ======== Multiple cursors ========

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

" Files by exact path match
nnoremap <silent> <leader>ee :call ContextMatcher()<CR>:<C-u>Unite -start-insert -buffer-name=project file_rec<CR>

" Files by fuzzy path match
nnoremap <silent> <leader>ef :call FuzzyMatcher()<CR>:<C-u>Unite -start-insert -buffer-name=project file_rec<CR>

" Recent files by exact match
nnoremap <silent> <leader>m :call ContextMatcher()<CR>:<C-u>Unite -buffer-name=recent file_mru<cr>

" Full text search by regex
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
