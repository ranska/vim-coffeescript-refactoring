require 'vimrunner'
require 'vimrunner/rspec'
require_relative 'support/vim'

Vimrunner::RSpec.configure do |config|
  config.reuse_server = true

  plugin_path = File.expand_path('.')

  puts plugin_path
  config.start_vim do
    vim = Vimrunner.start_gvim
    vim.add_plugin(plugin_path, 'plugin/patterns/all/add_parameter.vim')
    vim.add_plugin(plugin_path, 'plugin/vim-coffeescript-refactoring.vim')
    #vim.add_plugin(plugin_path,'../.mvimrc')

    def vim.select_lines first, last
      num_line = last - first
      feedkeys "#{first}GV#{num_line}j"
      self
    end

    vim
  end
end

RSpec.configure do |config|
  config.include Support::Vim
end
