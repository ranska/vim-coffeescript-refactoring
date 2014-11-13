" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
"nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
"nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
"nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
"nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
"vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
"vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
"vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
"vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
"onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
"onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
"onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
"onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>


function! AskFor(something)
  call inputsave()
  let name = input(a:something . ': ')
  call inputrestore()
  return name
endfunction
"work in progress
" 1) select line 
" https://github.com/ecomba/vim-ruby-refactoring/blob/master/plugin/refactorings/general/extractmethod.vim
" 2) cut line
" 3) input fonction name
"---> 4) write fonction name
" 5) move next indent lower level
" 6) write function name
" 7) paste core method
" message for check params
"

" simple version: extract method with name and past at endoffile
"

"
function! AppendNameIndented(name, indent)
  call append('.', repeat(' ', a:indent) . '@' . a:name . '()')
endfunction

"
"
function! CRExtractMethod() range
  let name      = AskFor('Method name')
  let indent    = indent(line('.'))
  let selection = split(common#cut_visual_selection(), '\n')
  call AppendNameIndented(name, indent)
  execute "normal! G"
  call append('.', name . ': ->')
  for i in selection
    "call setline('.', curline . '6' . name . i )
    execute "normal! G"
    call append('.', i)
  endfor
  execute "normal! \"kdG\"kp"
endfunction

"
"
"
function! CRAddParameter() range
  let name = AskFor('Parameter name')

  "find the first -> or => backward
  "?->\|=>"

  " Save current position
  let cursor_position = getpos(".")

  " Move backwards to the method definiton if you are not already on the
  " correct line
  if empty(matchstr(getline("."), '\<->\>'))
    exec "?->\\|=>"
  endif

  let closing_bracket_index = stridx(getline("."), ")")
  let opening_bracket_index = stridx(getline("."), "(")

  if closing_bracket_index == -1
    " execute "normal i(" . name . ") \<Esc>"
    " :s/.*\zs)\s\?[-=]>/, new_param&/
    execute "normal :s/[-=]>/(". name . ") &/\<CR>" 
    "execute "normal :s/\.\\*\\zs)\\s\\?[-=]>/, ". name . "&/\<CR>" 
    " there is an open & close paren but no parameters
  elseif opening_bracket_index != -1 && opening_bracket_index == closing_bracket_index - 1
    "exec ':s/)/' . name . ')/'
    execute "normal :s/)\\s\\?[-=]>/". name . "&/\<CR>" 
  else
    "exec ':.s/)/, ' . name . ')/'
    execute "normal :s/)\\s\\?[-=]>/, ". name . "&/\<CR>" 
  endif

  " Restore caret position
  call setpos(".", cursor_position)

  " there allrady params
  " add param
endfunction

