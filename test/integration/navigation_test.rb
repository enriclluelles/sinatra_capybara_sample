require_relative './integration_test_helper.rb'

class NavigationTest < MiniTest::Unit::JsIntegrationTestCase

  def setup
    visit("/hi")
    click_link("bye")
  end

  def test_navigation
    assert page.has_content?("have a nice day")
  end

end
