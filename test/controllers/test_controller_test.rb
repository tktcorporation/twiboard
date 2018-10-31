require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get board" do
    get test_board_url
    assert_response :success
  end

end
