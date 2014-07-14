require 'rubygems'
require 'capybara-webkit'
require 'sinatra/base'
require 'benchmark'

class App < Sinatra::Base
  get "/" do
    "<html><body><p>Hello</p></body></html>"
  end
end

server = Capybara::Server.new(App)
server.boot
app_host = "http://127.0.0.1:#{server.port}"
connection = nil
driver = nil
response = nil

Benchmark.bmbm do |x|
  x.report "Connect" do
    connection ||= Capybara::Webkit::Connection.new
  end

  x.report "Visit" do
    browser ||= Capybara::Webkit::Browser.new(connection)
    driver ||= Capybara::Webkit::Driver.new(App, browser: browser)
    10.times do
      driver.visit(app_host)
    end
  end

  x.report "Response" do
    response = driver.find_css("p").first.text
  end
end

puts "Tested using #{Capybara::Driver::Webkit::VERSION}"
puts "Connected to capybara-webkit on port #{connection.port}"
puts "Visited #{app_host}"
puts "Received response: #{response}"
