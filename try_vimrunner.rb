require 'vimrunner'

# Vim will automatically be started and killed.
Vimrunner.start do |vim|
  vim.edit "file.txt"
  vim.insert "Hello"
  vim.write
end
