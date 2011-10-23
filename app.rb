require "bundler/setup"
Bundler.require "default"

class App < Sinatra::Base
  Dir[File.dirname(__FILE__) + '/app/*.rb'].each {|file| require file }
end
