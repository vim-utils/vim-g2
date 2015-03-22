if exists('g:loaded_g2') && g:loaded_g2
  finish
endif
let g:loaded_g2 = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <Plug>(g2) :<C-U>call g2#g2()<CR>
nmap <silent> g2 <Plug>(g2)

let &cpo = s:save_cpo
unlet s:save_cpo
