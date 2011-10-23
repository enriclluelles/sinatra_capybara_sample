require_relative './integration_test_helper.rb'

class HiTest < MiniTest::Unit::IntegrationTestCase

  def setup
    visit("/hi")
  end

  def javascript?
    true
  end

  def test_hi
    assert page.has_content?("O hai!")
  end

end
