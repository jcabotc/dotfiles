let mapleader=','

" ======== Manage vim config ========

nmap <leader>v [vimrc]

" Edit .vimrc and filetype configs
nnoremap <silent> [vimrc]e :edit ~/.vim<CR>
nnoremap <silent> [vimrc]s :source ~/.vimrc<CR>:nohlsearch<CR>:echo 'Vimrc sourced'<CR><ESC>

" ======== Buffer ========

" Make Y act like other capitals
nmap Y y$

" Scroll to put the current line at the center of the screen
nnoremap <space> zz

" Turn off search highlight on ESC
nnoremap <silent> <ESC> :nohlsearch<CR><ESC>

" Coercion (abolish plugin)
"   crc: camelCase
"   crm: MixedCase
"   crs: snake_case
"   cru: UPPER_CASE

" Splitjoin
nmap <Leader>k :SplitjoinJoin<cr>
nmap <Leader>j :SplitjoinSplit<cr>

" Yankring
let g:yankring_replace_n_pkey = 'K' " previous register
let g:yankring_replace_n_nkey = 'Q' " next register

" ======== Comments ========

" Toggle on text objects
nmap <leader>c <Plug>Commentary
xmap <leader>c <Plug>Commentary
omap <leader>c <Plug>Commentary

" Toggle on current line
nmap <leader>cc V<leader>c

" ======== Multiple cursors ========

let g:VM_maps = {}

" Enter multi-select mode
let g:VM_maps['Find Under'] = '<C-n>'         " From normal
let g:VM_maps['Find Subword Under'] = '<C-n>' " From visual

" TODO: Investigate why `s` is not working in multi-select mode
" Multi-select mode mappings
let g:VM_maps['Switch Mode'] = 'v'        " Cursor to region selector
let g:VM_maps['Find Next'] = '<C-n>'      " Select nexta region
let g:VM_maps['Alt Skip'] = '<C-m>'       " Skip current region
let g:VM_maps['Remove Region'] = '<C-b>'  " Remove current region
let g:VM_maps['Surround'] = 'S'
let g:VM_maps['Numbers Append'] = '<C-e>'

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

" TODO: Improve general unite experience (open below, rethink matchers, supress buffer exit error, etc)

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

" ======== Style ========

function NextColorscheme()
  let index = -1

  if exists('g:colors_name')
    let pair = [g:colors_name, &background]
    let index = index(g:colorschemes, pair)
  endif

  let next_index = float2nr(fmod(index + 1, len(g:colorschemes)))
  let [scheme, bg] = g:colorschemes[next_index]
  execute 'colorscheme ' . scheme
  execute 'set background=' . bg
endfunction

map <leader>s :call NextColorscheme()<CR>
