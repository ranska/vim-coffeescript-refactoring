require 'spec_helper'
#Feature: Extract Method :RExtractMethod
#  Extracts the selected code into a new method of its own.

#    Shortcuts:
#      :RExtractMethod
#      <leader>rem

describe "convert post conditional" do
  let(:filename) { 'convert_post_conditional.coffee' }
  #  Scenario: Extract one line assignment into a new method
  #    Given I have the following code:
  specify "with params" do
    set_file_contents <<-EOF
do_something if condition
    EOF
    vim.command 'set number'
    vim.command 'hi Visual  guifg=#FFFF00 guibg=#003322 gui=none'
    vim.edit filename
    vim.feedkeys '\\<esc>'
    sleep 2
    vim.write
    vim.type ':call CRConvertPostConditional()'
    vim.feedkeys '\\<CR>'
    sleep 2
    # And I fill in the parameter "add"
    vim.feedkeys 'add\\<CR>'
    sleep 5

    #    Then I should see:
    assert_file_contents <<-EOF 
if condition
  do_something
    EOF
  end
end

#
# NOTE test first extract method 
# without params
#
