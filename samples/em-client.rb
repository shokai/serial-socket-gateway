#!/usr/bin/env ruby
require 'rubygems'
require 'eventmachine'

HOST = 'localhost'
PORT = 8782
RECONNECT_INTERVAL = 5

class SerialClient < EM::Connection
  def post_init
    puts "connect!! - #{HOST}:#{PORT}"
    EM::defer do
      loop do
        send_data gets.gsub(/[\r\n]/, '')
      end
    end
  end

  def receive_data(data)
    puts data
  end

  def unbind
    puts "connection closed - #{HOST}:#{PORT}"
    EM::add_timer(RECONNECT_INTERVAL) do
      reconnect(HOST, PORT)
    end
  end
end

EventMachine::run do
  EM::connect(HOST, PORT, SerialClient)
end

