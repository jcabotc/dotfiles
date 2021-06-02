let mapleader=','

" ======== Manage vim config ========

" Edit .vimrc and filetype configs
nnoremap <silent> <leader>ve :edit ~/.vim<CR>
nnoremap <silent> <leader>vs :source ~/.vimrc<CR>:nohlsearch<CR>:echo 'Vimrc sourced'<CR><ESC>

" ======== Buffer ========

" Simple save and quit
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

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

" Toggle indent guides
nmap <leader>it :IndentLinesToggle<CR>

" ======== Language server ========

" Show documentation for the word under the cursor
nnoremap <silent> <leader>d :call CocActionAsync('doHover')<CR>
nnoremap <silent> <leader>D :call CocActionAsync('doHover', 'split')<CR>

" Open diagnostic on another split
nnoremap <silent> <leader>se :call CocAction('diagnosticPreview')<CR>

" Jump to next or previous error
nmap <silent> <leader>sp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>sn <Plug>(coc-diagnostic-next)

" Fix error under the cursor
nmap <leader>sf <Plug>(coc-codeaction)

" Rename symbol
nmap <leader>sr <Plug>(coc-rename)

" Go to
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gr <Plug>(coc-references)

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
let g:VM_maps['Find Next'] = '<C-n>'      " Select next region
let g:VM_maps['Skip Region'] = '<C-m>'    " Skip current region
let g:VM_maps['Remove Region'] = '<C-b>'  " Remove current region
let g:VM_maps['Surround'] = 'S'
let g:VM_maps['Numbers Append'] = '<C-e>'

" ======== Splits ========

" Move between splits
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" Resize splits
nnoremap <leader>rw :vertical resize +5<CR>
nnoremap <leader>rW :vertical resize -5<CR>
nnoremap <leader>rh :resize +5<CR>
nnoremap <leader>rH :resize -5<CR>

" ======== Project tree ========

" Toggle tree
nnoremap <leader>n :NERDTreeToggle<CR>

" Reveal current file
nnoremap <leader>cn :NERDTreeFind<CR>

" ======== Search files ========

" Files by fuzzy path match
nnoremap <leader>e :Files<CR>

" Recent files by exact match
nnoremap <leader>m :History<CR>

" Full text search by regex
nnoremap <leader>f :Ag<CR>

" ======== Git ========

" Git status (-: stage/unstage, =: show diff)
nnoremap <silent> <leader>ts :Gstatus<CR>

" On the current file
nnoremap <silent> <leader>tb :Gblame<CR>
nnoremap <silent> <leader>td :Gvdiff<CR>
nnoremap <silent> <leader>tr :Gread~0<CR>

" ======== Filesystem ========

" Copy current file path to system clipboard
nmap <silent> <leader>cp :let @*=expand("%")<CR>:echo 'Path copied to system clipboard'<CR>

" ======== SSH ========

" Send visual selection to remote clipboard

" vmap yr :call system("ssh $machineA_IP pbcopy", @*)<CR>
" vmap <leader>rc :<,'>:w !"ssh mac pbcopy"<CR>
" xnoremap <leader>rc <esc>:'<,'>:w !ssh mac pbcopy<CR>
xnoremap <leader>sy y<esc>:call CopyYankedToRemote()<CR>

function CopyYankedToRemote() 
  execute '!echo "' . @" . '" | ssh mac pbcopy'
endfunction
