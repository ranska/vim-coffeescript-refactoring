require 'spec_helper'
#Feature: Extract Method :RExtractMethod
#  Extracts the selected code into a new method of its own.

#    Shortcuts:
#      :RExtractMethod
#      <leader>rem

=begin
describe "extract method" do
  let(:filename) { 'extract_method.coffee' }
  #  Scenario: Extract one line assignment into a new method
  #    Given I have the following code:
  specify "with params" do
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
    vim.command 'set number'
    vim.command 'hi Visual  guifg=#FFFF00 guibg=#003322 gui=none'
    vim.edit filename
    vim.feedkeys '\\<esc>'
    sleep 2
    vim.write
    vim.select_lines 8, 11
    sleep 2
    #vim.feedkeys ':call CRExtractMethod()\\<CR>'
    vim.type ':call CRExtractMethod()'
    vim.feedkeys '\\<CR>'
    sleep 2
    # And I fill in the parameter "add"
    vim.feedkeys 'add\\<CR>'
    sleep 5

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
=end
WITH_PAUSES = false
WITH_END_PAUSES = true

#
# NOTE test first extract method 
# without params
#
describe "extract method" do
  let(:filename) { 'extract_method.coffee' }
  #  Scenario: Extract one line assignment into a new method
  #    Given I have the following code:
  specify "without params" do
    set_file_contents <<-EOF
class Foo
  method_one: ->
    a = 1
    b = 2
    c = 3
    EOF
    set_up
    vim.write
    vim.select_lines 4, 5
    sleep 2 if WITH_PAUSES
    #vim.feedkeys ':call CRExtractMethod()\\<CR>'
    vim.type ':call CRExtractMethod()'
    vim.feedkeys '\\<CR>'
    sleep 2 if WITH_PAUSES
    # And I fill in the parameter "add"
    vim.feedkeys 'add\\<CR>'
    sleep 4 if WITH_PAUSES or WITH_END_PAUSES
    vim.feedkeys ':w\\<CR>'

    #    Then I should see:
    assert_file_contents <<-EOF 
class Foo
  add: ->
    b = 2
    c = 3

  method_one: ->
    a = 1
    @add()
    EOF
  end
end

#
# NOTE test first extract method 
# without params
#
#

def set_up
    vim.command 'set number'
    vim.command 'hi Visual  guifg=#FFFF00 guibg=#003322 gui=none'
    vim.edit filename
    vim.feedkeys '\\<esc>'
    sleep 2 if WITH_PAUSES
end
