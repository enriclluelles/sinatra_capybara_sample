require 'test_helper'
require 'capybara'
require 'capybara/dsl'

module MiniTest
  class Unit
    class IntegrationTestCase < TestCase
      include Capybara::DSL

      #Minitest provides us with post_setup_hooks but not with
      #pre hooks so I did this quick hack
      def setup_with_pre_hook
        Capybara.current_driver = :selenium_chrome if javascript?
        setup_with_no_hooks
      end
      alias :setup_with_no_hooks :setup
      alias :setup :setup_with_pre_hook

      #We should find a better way to do this
      def javascript?
        false
      end

      add_teardown_hook Proc.new{ Capybara.use_default_driver }
    end
  end
end

Capybara.register_driver :selenium_chrome do |app|
  #We need to download the chrome webdriver and have it on our path
  #  http://code.google.com/p/selenium/wiki/ChromeDriver
  #  http://code.google.com/p/chromium/downloads/list
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.app = Sinatra::Application.new
Capybara.run_server = true
