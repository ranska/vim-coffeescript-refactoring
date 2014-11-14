

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

