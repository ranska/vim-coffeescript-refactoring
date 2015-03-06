" extract local variable {{{
function! CRExtractLocalVariable() range
  let name      = AskFor('Variable name')
  " rechercher dans le block (function)
  " remplacer le range par le name
  " ecrire la definition name = range
  " placer la definition au début du bloc
endfunction
" }}}
