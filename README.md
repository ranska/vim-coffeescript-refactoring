[![Travis CI   ](http://img.shields.io/travis/ranska/rang/master.svg)](https://travis-ci.org/ranska/rang)
[![Stories in Ready](https://badge.waffle.io/ranska/vim-coffeescript-refactoring.png?label=ready&title=Ready)](https://waffle.io/ranska/vim-coffeescript-refactoring)
vim-coffeescript-refactoring
============================

Refactoring tool for Coffeescript in vim!
same feeling has [vim-ruby-refactoring](https://github.com/ecomba/vim-ruby-refactoring)
Thanks to [AndrewRadev](https://github.com/AndrewRadev)

### You can help

new idea, bugs... please open issue.

You have some spec or exemple, please forkit and add them to the tests and make
a pull request :) 

You know vimscript please take an issue i will merge tested pull request :)


Current work in progress
========================
```
  :CRAddParameter           - Add Parameter 
  :CRExtractMethod          - Extract Method   
```
Now you can install the plugin and try extract method.
this is a very early version.
To play with it add this to your .vimrc
```
  nnoremap <leader>cem :call CRExtractMethod()<cr>
```

For any problem please open an issue



## Install

vim-coffeescript-refactoring follows the standard runtime path structure, so I highly recommend to use
a common and well known plugin manager to install vim-coffeescript-refactoring.
For Pathogen just clone the repo, for other plugin managers
add the appropriate lines and execute the plugin's install command.

*  [Pathogen](https://github.com/tpope/vim-pathogen)
  * `git clone https://github.com/ranska/vim-coffeescript-refactoring.git ~/.vim/bundle/vim-coffeescript-refactoring`
*  [vim-plug](https://github.com/junegunn/vim-plug)
  * `Plug 'ranska/vim-coffeescript-refactoring'`
*  [NeoBundle](https://github.com/Shougo/neobundle.vim)
  * `NeoBundle 'ranska/vim-coffeescript-refactoring'`
*  [Vundle](https://github.com/gmarik/vundle)
  * `Plugin 'ranska/vim-coffeescript-refactoring'`
*  Manual
  *  Copy all of the files into your `~/.vim` directory



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

