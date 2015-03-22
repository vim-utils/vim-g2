if exists('g:autoloaded_g2') && g:autoloaded_g2
  finish
endif
let g:autoloaded_g2 = 1

function! g2#g2()
  let current_char = matchstr(getline('.')[col('.')-1:-1],'.')
  silent let full_output = systemlist('xxd -b', current_char)
  let bytes_output = join(map(full_output, 'join(split(v:val)[1:-2])'))

  if &encoding =~# '^utf'
    " improve display for composing characters
    echom substitute(bytes_output, ' 11', ' + 11', 'g')
  else
    echom bytes_output
  endif
endfunction
