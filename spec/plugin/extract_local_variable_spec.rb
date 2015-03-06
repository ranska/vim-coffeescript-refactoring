require 'spec_helper'
#Feature: Extract Local Variable :CRExtractLocalVariable
#  Extracts the selected code into a new method of its own.

#    Shortcuts:
#      :CRExtractLocalVariable
#      <leader>crelv

WITH_PAUSES = true
WITH_END_PAUSES = true

#
# NOTE test first extract method 
# without params
#
describe "extract local variable" do
  let(:filename) { 'extract_local_variable.coffee' }
  #  Scenario: Extract one line assignment into a new method
  #    Given I have the following code:
  specify "basic example" do
    set_file_contents <<-EOF
fetchWithFilter: ->
  @fetchWithoutFilter(data: @getFilterParams())
    EOF
    set_up
    vim.write
    vim.select_lines 4, 5
    sleep 2 if WITH_PAUSES
    #vim.feedkeys ':call CRExtractMethod()\\<CR>'
    vim.type ':call CRExtractLocalVariable()'
    vim.feedkeys '\\<CR>'
    sleep 2 if WITH_PAUSES
    # And I fill in the parameter "add"
    vim.feedkeys 'data\\<CR>'
    sleep 4 if WITH_PAUSES or WITH_END_PAUSES
    vim.feedkeys ':w\\<CR>'

    #    Then I should see:
    assert_file_contents <<-EOF 
fetchWithFilter: ->
  data = @getFilterParams()
  @fetchWithoutFilter(data: data)
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
