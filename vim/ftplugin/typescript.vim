" Insert "(x) => x," in a pipe
"   inline
nmap <buffer><silent> <leader>xii i, x => x<ESC>:call CocActionAsync('doHover')<CR>
"   in a new row below
nmap <buffer><silent> <leader>xio ox => x,<ESC>h:call CocActionAsync('doHover')<CR>
