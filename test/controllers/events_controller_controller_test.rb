require 'test_helper'

class EventsControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get events_controller_index_url
    assert_response :success
  end

end
