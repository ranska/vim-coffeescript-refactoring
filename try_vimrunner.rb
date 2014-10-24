#♥require 'vimrunner'

# Vim will automatically be started and killed.
#Vimrunner.start do |vim|
#  vim.edit "file.txt"
#  vim.insert "Hello"
#  vim.write
#end


require 'vimrunner'
require 'vimrunner/rspec'

=begin
Vimrunner::RSpec.configure do |config|
  # Use a single Vim instance for the test suite. Set to false to use an
  # instance per test (slower, but can be easier to manage).
  config.reuse_server = true

  # Decide how to start a Vim instance. In this block, an instance should be
  # spawned and set up with anything project-specific.
  config.start_vim do
    vim = Vimrunner.start♥

    # Or, start a GUI instance:
    # vim = Vimrunner.start_gvim

    # Setup your plugin in the Vim instance
    plugin_path = File.expand_path('../..', __FILE__)
    vim.add_plugin(plugin_path, 'plugin/my_plugin.vim')

    # The returned value is the Client available in the tests.
    #♥♥vim
    vim.edit "my_spec.rb"
it 'does not create a mapping if one already exists' do
      using_vim_without_plugin do |clean_vim|
expect(clean_vim).to have_no_normal_map_from('<Leader>a')
end
end
end
  end
=end


#require 'vimrunner'

Vimrunner::RSpec.configure do |config|
  config.reuse_server = true
  plugin_path = File.expand_path('.')
  config.start_vim do
    vim = Vimrunner.start_gvim
    #vim.add_plugin(plugin_path, 'plugin/splitjoin.vim')
    vim
  end
end
module Support
  module Vim
    def set_file_contents(string)
      write_file(filename, string)
      vim.edit!(filename)
    end
    def split
      vim.command 'SplitjoinSplit'
      vim.write
    end
    def join
      vim.command 'SplitjoinJoin'
      vim.write
    end
    def assert_file_contents(string)
      string = normalize_string_indent(string)
      IO.read(filename).strip.should eq string
    end
  end
end
RSpec.configure do |config|
  config.include Support::Vim
end
#vim = Vimrunner.start_gvim
#vim.add_plugin(File.expand_path('.'), 'plugin/linediff.vim')
#vim.command('source ~/.vim/plugin/cecutil.vim')
#vim.command('source ~/.vim/plugin/Decho.vim')
#♥vim.edit('example/one.rb')
#vim.normal('Vjj:Linediff<cr>')
#vim.command('bi')
#vim.normal('Vjj:Linediff<cr>')
describe "coffee" do
  let(:filename) { 'test.coffee' }
  specify "functions" do
    vim.insert 'toto'
    #vim.command('LinediffReset')

    set_file_contents <<-EOF
(foo, bar) ->
console.log foo
    EOF
    #join
    assert_file_contents "(foo, bar) -> console.log foo"
  end
  #vim.kill
end

#
# test extract method
#
# avec 1 niveau de prof
#
# 0 niveau
#
# 2 ou 3
#
# avec fat ou normal arrow
#
#  
#
#
