require 'test_helper'
require 'capybara'
require 'capybara/dsl'

module MiniTest
  class Unit
    class IntegrationTestCase < TestCase
      include Capybara::DSL
    end

    class JsIntegrationTestCase < IntegrationTestCase
      def self.do_at_exit inheritor
        at_exit do
          inheritor.module_eval do
            alias_method :setup_with_no_hook, :setup
            def setup
              Capybara.current_driver = :selenium_chrome
              setup_with_no_hook
            end

            alias_method :teardown_with_no_hook, :teardown
            def teardown
              teardown_with_no_hook
              Capybara.use_default_driver
            end
          end
        end
      end

      def self.inherited klass
        do_at_exit klass
        super
      end
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
