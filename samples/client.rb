#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'socket'
require 'eventmachine'

HOST = "localhost"
PORT = 8782

begin
  s = TCPSocket.open(HOST, PORT)
rescue => e
  STDERR.puts e
  exit 1
end

EventMachine::run do
  EventMachine::defer do
    loop do
      res = s.gets
      exit unless res
      puts res
    end
  end

  EventMachine::defer do
    loop do
      s.puts gets
    end
  end
end

