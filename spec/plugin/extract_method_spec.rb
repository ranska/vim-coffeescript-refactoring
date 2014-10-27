require 'spec_helper'
#Feature: Extract Method :RExtractMethod
#  Extracts the selected code into a new method of its own.

#    Shortcuts:
#      :RExtractMethod
#      <leader>rem

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
    # When I select "two + three" and execute:
    vim.command 'CRExtractMethod'
    # And I fill in the parameter "add"
    vim.feedkeys 'add\<C-R>'

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


