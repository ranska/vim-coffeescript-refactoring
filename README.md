[![Stories in Ready](https://badge.waffle.io/ranska/vim-coffeescript-refactoring.png?label=ready&title=Ready)](https://waffle.io/ranska/vim-coffeescript-refactoring)
vim-coffeescript-refactoring
============================

Refactoring tool for Coffeescript in vim!
same feeling has [vim-ruby-refactoring](https://github.com/ecomba/vim-ruby-refactoring)
Thanks to [AndrewRadev](https://github.com/AndrewRadev)

Current work in progress
========================
```
  :CRAddParameter           - Add Parameter 
  :CRExtractMethod          - Extract Method   
```

Test Road map
========

- test on travis
- improve practive in vimrunner


Vim ecosystem Road map
======================

- vundle pathogen compatible
- augroup filetype_vim
- nnoramp default write on readme

 
Paterns Road map
================

```
  :CRInlineTemp             - Inline Temp
  :CRConvertPostConditional - Convert Post Conditional
  :CRExtractConstant        - Extract Constant          
  :CRExtractLocalVariable   - Extract Local Variable    
  :CRRenameLocalVariable    - Rename Local Variable     
  :CRRenameInstanceVariable - Rename Instance Variable  
```

How to run tests
================

Use rspec

```
  rspec spec/plugin/add_parameter_spec.rb
```

