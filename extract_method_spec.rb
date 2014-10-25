require 'vimrunner'
require 'vimrunner/rspec'

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

describe "coffee" do
#Feature: Extract Method :RExtractMethod
#  Extracts the selected code into a new method of its own.

#    Shortcuts:
#      :RExtractMethod
#      <leader>rem

#  Scenario: Extract one line assignment into a new method
#    Given I have the following code:
  let(:filename) { 'test.coffee' }
  specify "functions" do
    set_file_contents <<-EOF
class Foo
  method_one: ->
    @bar = foo

  method_two: ->
    one = 1
    two = 2
    three = 3
    four = two + two
    five = two + three
    six = five + one
    EOF
    #    When I select "two + three" and execute:
    #"""
    #:RExtractMethod
    #"""
#    And I fill in the parameter "add"

#    Then I should see:
    assert_file_contents <<-EOF 
class Foo
  method_one: ->
    @bar = foo

  add: (two, three) ->
    two + three

  method_two: ->
    one = 1
    two = 2
    three = 3
    four = two + two
    five = add(two, three)
    six = five + one
    EOF
  end
end

#
# NOTE test first extract method 
# without params
#


