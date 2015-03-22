if exists('g:autoloaded_g2') && g:autoloaded_g2
  finish
endif
let g:autoloaded_g2 = 1

function! s:current_char(type)
  " get current char, even if it's multibyte (from @tpope's vim-characterize)
  let current_char = matchstr(getline('.')[col('.')-1:-1],'.')

  if a:type ==# 'buffer'
    " character has the same encoding as the buffer it's been taken from
    return current_char

  elseif a:type ==# 'file'
    " encode the character in the same encoding as when it's written to a file
    if empty(&fileencoding) || &encoding ==# &fileencoding
      " conversion not necessary (most often the case)
      return current_char
    elseif has('multi_byte')
      " try converting current char to the same encoding as the current file
      if has('iconv')
        " can transcode anything
        return iconv(current_char, &encoding, &fileencoding)
      elseif (&encoding ==# 'utf-8' || &encoding ==# 'latin1')
            \ && (&fileencoding ==# 'utf-8' || &fileencoding ==# 'latin1')
        " can transcode only 'utf-8' <=> 'latin1'
        return iconv(current_char, &encoding, &fileencoding)
      else
        " can't make transcoding (shouldn't happen)
        return current_char
      endif
    else
      " can't make transcoding (shouldn't happen)
      return current_char
    endif
  endif
endfunction

function! s:relevant_encoding(type)
  if a:type ==# 'file'
    return &fileencoding
  elseif a:type ==# 'buffer'
    return &encoding
  endif
endfunction

function! bin#g2(type)
  silent let full_output = systemlist('xxd -b', <SID>current_char(a:type))
  let bytes_output = join(map(full_output, 'join(split(v:val)[1:-2])'))

  let enc = <SID>relevant_encoding(a:type)
  if enc ==# 'utf-8'
    " improve display for composing characters
    echom substitute(bytes_output, ' 11', ' + 11', 'g')
  else
    echom bytes_output
  endif
endfunction

function! bin#g8(type)
  echom <SID>current_char(a:type)
  silent let hex_output = systemlist('xxd -ps', <SID>current_char(a:type))[0]
  " insert spaces between each 2 hex characters
  let hex_output = substitute(hex_output, '..', ' &', 'g')[1:-1]

  let enc = <SID>relevant_encoding(a:type)
  if enc ==# 'utf-8'
    " improve display for composing characters
    echom substitute(hex_output, ' [cdef]', ' +&', 'g')
  else
    echom hex_output
  endif
endfunction
