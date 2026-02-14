require "test_helper"

class StatusesControllerTest < ActionDispatch::IntegrationTest
  test "should get healthcheck" do
    get statuses_healthcheck_url
    assert_response :success
  end
end
