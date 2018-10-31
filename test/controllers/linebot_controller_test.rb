require 'test_helper'

class LinebotControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get linebot_top_url
    assert_response :success
  end

end
