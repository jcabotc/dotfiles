" TODO: Investigate why it fails sometimes
" Mix format
nmap <buffer><silent> <leader>xx :MixFormat<CR>
nmap <buffer><silent> <leader>xd :MixFormatDiff<CR>

" IO.inspect() on a new line under the cursor
nmap <buffer><silent> <leader>xio oIO.inspect()<left>
" |> IO.inspect() on a new line in a pipe
nmap <buffer><silent> <leader>xip o\|><space>IO.inspect()<ESC>
" Inline
nmap <buffer><silent> <leader>xii a<space>\|><space>IO.inspect()<ESC>
