require 'rubygems'
require 'capybara-webkit'
require 'benchmark'

connection = nil

Benchmark.bm do |x|
  x.report "Connection.new" do
    connection = Capybara::Webkit::Connection.new
  end

  %w(
    open_pipe
    discover_port
    discover_pid
    forward_output_in_background_thread
    connect
  ).each do |step|
    x.report step do
      connection.send(step)
    end
  end
end

puts "Port: #{connection.port}"
