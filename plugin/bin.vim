if exists('g:loaded_g2') && g:loaded_g2
  finish
endif
let g:loaded_g2 = 1

let s:save_cpo = &cpo
set cpo&vim

" support utf8 combined characters (up to 6 of them) é
" - test on windows (paperweight)
" + <c-g>2
" + g2
" <c-g>8 - external hex (fileencoding)
" - how are multibyte chars working with other encodings utf16, utf32?
" - test with 6 combining characters

nnoremap <silent> <Plug>(file_g2) :<C-U>call bin#g2('file')<CR>
nmap <silent> <C-G>2 <Plug>(file_g2)

nnoremap <silent> <Plug>(g2) :<C-U>call bin#g2('buffer')<CR>
nmap <silent> g2 <Plug>(g2)

nnoremap <silent> <Plug>(file_g8) :<C-U>call bin#g8('file')<CR>
nmap <silent> <C-G>8 <Plug>(file_g8)

let &cpo = s:save_cpo
unlet s:save_cpo
