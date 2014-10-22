vim-coffeescript-refactoring
============================

Test Road map
========

- test on travis
- cucumber test
- test with vim runner

Ressource
=======

http://andrewradev.com/2011/11/15/driving-vim-with-ruby-and-cucumber/

https://github.com/AndrewRadev/vimrunner


Run test
======

you need to compiled with the |+clientserver| 

with brew
=======

```
brew update

brew install vim --with-client-server

```

if you have allready install vim with brew

```
brew uninstall vim
brew update
$ brew install vim --override-system-vi --with-client-server 
      
      ## see brew options vim
      ## --with-lua \
      ## --with-mzscheme --with-perl --with-tcl
```
