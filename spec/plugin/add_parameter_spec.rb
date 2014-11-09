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
  describe "without parenthesis" do
    specify "begin off line" do
    set_file_contents <<-EOF
-> 
EOF
    add_parameter
    assert_file_contents <<-EOF 
(new_param) ->
EOF
    end

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
    sleep 2
    vim.write
    vim.select_lines 8, 11
    sleep 2
    vim.type ':call CRAddParameter()'
    vim.feedkeys '\\<CR>'
    sleep 2
    # And I fill in the parameter "add"
    vim.feedkeys 'new_param\\<CR>'
    sleep 5
    #    Then I should see:
end

#
# NOTE test first extract method 
# without params
#
