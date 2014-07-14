require 'rubygems'
require 'capybara-webkit'
require 'benchmark'

Benchmark.bm do |x|
  x.report "Connection.new" do
    port = Capybara::Webkit::Connection.new.port
    puts
    puts "Port: #{port}"
    puts
  end
end
