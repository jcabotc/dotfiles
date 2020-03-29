nnoremap <Leader>t :GhcModType<cr>
nnoremap <Leader>tc :GhcModTypeClear<cr>
autocmd FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>
