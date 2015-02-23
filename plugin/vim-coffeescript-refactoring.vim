" Load all refactoring recipes
exec 'runtime ' . resolve(expand('<sfile>:p:h')) . '/patterns/all/*.vim'

" Next Indent {{{
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
" {{{
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
" }}}
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
" }}}

function! AskFor(something)
  call inputsave()
  let name = input(a:something . ': ')
  call inputrestore()
  return name
endfunction
" Append functions {{{
function! AppendNameIndented(name, indent)
  call append('.', repeat(' ', a:indent) . '@' . a:name . '()')
endfunction

function! AppendIndented(text, indent)
  call append('.', repeat(' ', a:indent) . a:text)
endfunction

function! AppendCallFunctionIndented(name, indent)
  call AppendIndented('@' . a:name . '()', a:indent)
endfunction

function! AppendDefineFunctionIndented(name, indent)
  call AppendIndented(a:name . ': ->', a:indent)
endfunction

function! AppendBodyMethod(body)
  for line in a:body
    execute "normal! j"
    call append('.', line)
  endfor
endfunction

" }}}

function! MoveToTargetPaste()
  "execute "normal! G"
  call NextIndent(0, 0, 1, 0)
  execute "normal! k"
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
" simple version: extract method with name and past at endoffile
"
" extract method {{{
function! CRExtractMethod() range
  let name      = AskFor('Method name')
  let indent    = indent(line('.'))
  let selection = split(common#cut_visual_selection(), '\n')
  call AppendCallFunctionIndented(name, indent)
  call MoveToTargetPaste()
  call AppendDefineFunctionIndented(name, indent - 2)
  call AppendBodyMethod(selection)
  execute "normal! j"
  call append('.', '')
  "TODO Please HELP! i don't remember why there is this line ?
  execute "normal! \"kdG\"kp"
endfunction
" }}}
"call append('.', name . ': ->')
"call AppendNameIndented(name, indent)
"call setline('.', curline . '6' . name . i )
