require 'spec_helper'
#Feature: Extract Method :RExtractMethod
#  Extracts the selected code into a new method of its own.

#    Shortcuts:
#      :RExtractMethod
#      <leader>rem

describe "Add parameter" do
  let(:filename) { 'extract_method.coffee' }
  #  Scenario: Extract one line assignment into a new method
  #    Given I have the following code:
  describe "without parenthesis" do
    specify "begin off line" do
    set_file_contents <<-EOF
-> 
  toto + 3
EOF
    add_parameter
    assert_file_contents <<-EOF 
(new_param) ->
  toto + 3
EOF
    end

=begin
    specify "as function argument" do
    set_file_contents <<-EOF
foo -> 
EOF
    add_parameter
    assert_file_contents <<-EOF 
foo (new_param) ->
EOF
    end

    specify "in a function of fuction call" do
    set_file_contents <<-EOF
bar(foo) ->
bar(foo)() ->
-> 
EOF
    add_parameter
    assert_file_contents <<-EOF 
bar(foo) (new_param) ->
bar(foo)() (new_param) ->
EOF
    end
=end
  end

  # bar( ->
  #  foo
  # )

  describe "with parenthesis" do
    # () ->
    # (foo) ->
    # bar (foo) ->
  end
end


def add_parameter
    vim.command 'set number'
    vim.command 'hi Visual  guifg=#FFFF00 guibg=#003322 gui=none'
    vim.edit filename
    vim.feedkeys '\\<esc>'
    vim.write
    sleep 1
    vim.feedkeys 'G'
    vim.type ':call CRAddParameter()'
    vim.feedkeys '\\<CR>'
    sleep 1
    # And I fill in the parameter "add"
    vim.feedkeys 'new_param\\<CR>'
    sleep 3
    #    Then I should see:
end

#
# NOTE test first extract method 
# without params
#
