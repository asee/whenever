require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class OutputUserTest < Test::Unit::TestCase
  
  context "A plain command with the username_to_include set" do
    setup do
      @output = Whenever.cron :username_to_include => 'someusername', :string => 
      <<-file
        every 2.hours do
          command "blahblah"
        end
      file
    end
    
    should "output the command with the user name" do
      assert_match /^.+ .+ .+ .+ someusername blahblah$/, @output
    end
  end
    
end