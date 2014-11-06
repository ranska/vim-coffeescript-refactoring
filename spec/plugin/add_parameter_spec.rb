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
    write spec for 
    object_member: -> 
    object_fat_arrow: =>
    var = ->
    var_fat = =>
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
    vim.type ':call CRAddParameter()'
    vim.feedkeys '\\<CR>'
    sleep 2
    # And I fill in the parameter "add"
    vim.feedkeys 'add\\<CR>'
    sleep 5

    #    Then I should see:
    assert_file_contents <<-EOF 
    object_member: (add) -> 
    object_fat_arrow: (add) =>
    var = (add) ->
    var_fat = (add) =>
    EOF
  end
end

#
# NOTE test first extract method 
# without params
#
