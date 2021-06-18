let mapleader=','

" ======== Vim config ========

" Edit .vimrc and filetype configs
nnoremap <silent> <leader>ve :edit ~/.vim<CR>
nnoremap <silent> <leader>vs :source ~/.vimrc<CR>:nohlsearch<CR>:echo 'Vimrc sourced'<CR><ESC>

" ======== Basics ========

" Simple save and quit
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

" Turn off search highlight on ESC
nnoremap <silent> <ESC> :nohlsearch<CR><ESC>

" Make Y act like other capitals
nmap Y y$

" Yankring
let g:yankring_replace_n_pkey = 'K' " previous register
let g:yankring_replace_n_nkey = 'Q' " next register

" Scroll to put the current line at the center of the screen
nnoremap <space> zz

" Toggle indent guides
nmap <leader>it :IndentLinesToggle<CR>

" ======== Language server ========

" Documentation for the word under the cursor
nmap <silent> <leader>d :call CocActionAsync('doHover')<CR>
nmap <silent> <leader>D :call CocActionAsync('doHover', 'split')<CR>
" Diagnostics for the word under the cursor
nmap <silent> <Leader>e :call CocAction('diagnosticInfo')<CR>
nmap <silent> <leader>E :call CocAction('diagnosticPreview')<CR>

" Diagnostics navigation
nmap <silent> <leader>sd :CocDiagnostics<CR>
nmap <silent> <leader>sp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>sn <Plug>(coc-diagnostic-next)

" Suggest fixes for the diagnostic under the cursor (and others)
nmap <leader>sf <Plug>(coc-codeaction)
" Rename symbol under the cursor
nmap <leader>sr <Plug>(coc-rename)

" Go to
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gr <Plug>(coc-references)

" Show server status
nmap <silent> <leader>ss :echo CocAction('services')<CR>

" ======== New commands ========

" Coercion (abolish plugin)
" crc: camelCase
" crm: MixedCase
" crs: snake_case
" cru: UPPER_CASE

" Splitjoin
nmap <Leader>k :SplitjoinJoin<cr>
nmap <Leader>j :SplitjoinSplit<cr>

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

" Multi-select mode mappings
let g:VM_maps['Switch Mode'] = 'v'        " Multi-normal to multi-visual
let g:VM_maps['Find Next'] = '<C-n>'      " Select next region
let g:VM_maps['Skip Region'] = '<C-m>'    " Skip current region
let g:VM_maps['Remove Region'] = '<C-b>'  " Remove current region
let g:VM_maps['Surround'] = 'S'
let g:VM_maps['Numbers Append'] = '<C-e>'

" ======== Splits ========

" Navigate
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h
" Resize
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

" Fuzzy file match
nnoremap <leader>ff :Files<CR>
" Recent file match
nnoremap <leader>fh :History<CR>
" Full text match
nnoremap <leader>fi :Ag<CR>

" C-p: Previous search pattern
" C-n: Next search pattern

" ======== Git ========

" Git status
nnoremap <silent> <leader>ts :Git status<CR>
" s: stage
" u: unstage
" =: show diff
" cc: commit
" ca: amend commit

" On the current file
nnoremap <silent> <leader>tb :Git blame<CR>
nnoremap <silent> <leader>td :Gvdiff<CR>
nnoremap <silent> <leader>tr :Gread<CR>

" ======== Mac ssh ========

" Set visual selection to mac's clipboard
xnoremap <leader>m y<esc>:'<,'>call CopyYankedToRemote()<CR>

function CopyYankedToRemote() range
  let originalPosition = getpos(".")
  echo system('echo -n ' . shellescape(@") . '| ssh mac pbcopy')
  echo "Selection to mac clipboard"
  call setpos('.', originalPosition)
endfunction

" Set current file path to mac's clipboard
nnoremap <leader>mf :call CopyCurrentFilePathToRemote()<CR>

function CopyCurrentFilePathToRemote() range
  let originalPosition = getpos(".")
  echo system('echo -n ' . shellescape(expand("%")) . '| ssh mac pbcopy')
  echo "Current path to mac clipboard"
  call setpos('.', originalPosition)
endfunction
