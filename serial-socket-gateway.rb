# -*- coding: utf-8 -*-
require 'serialport'
require 'rubygems'
require 'eventmachine'
require 'socket'
$KCODE = 'u'

if ARGV.size < 1
  puts 'ruby serial-socket-gateway.rb /dev/tty/tty-usbdevice'
  exit 1
end

TCP_PORT = 8782

sock = TCPServer.open TCP_PORT
p sock.addr

clients = Array.new
serial_to_clients = Array.new

serial_device = ARGV.shift
sp = SerialPort.new(serial_device, 9600, 8, 1, SerialPort::NONE) # 9600bps, 8bit, ストップビット1, パリティ無し


EventMachine::run do

  # serial -> STDOUT
  EventMachine::defer do
    loop do
      data = sp.gets
      serial_to_clients << data
      puts data
    end
  end

  # STDIN -> serial
  EventMachine::defer do
    loop do
      line = gets
      sp.puts line
    end
  end
  
  # serial -> clients
  EventMachine::defer do
    loop do
      while serial_to_clients.size > 0 do
        data = serial_to_clients.shift
        errors = Array.new
        clients.each{|c|
          begin
            c.puts data
          rescue => e
            errors << c
            STDERR.puts e
          end
        }
        errors.each{|c|
          clients.delete(c)
          c.close
        }
      end
    end
  end
  
  
  # check clients connection
  EventMachine::defer do
    loop do
      errors = Array.new
      clients.each{|c|
        begin
          c.puts ''
        rescue => e
          STDERR.puts e
          errors << c
        end
      }
      errors.each{|c|
        clients.delete(c)
        c.close
      }
      sleep 10
    end
  end
  
  # accept socket clients
  EventMachine::defer do
      loop do
      c = sock.accept
      clients << c
      puts "--- clients : #{clients.size}"
      Thread.start(c) do |c|
          loop do
          #EventMachine::run do # socket -> serial
          puts line = c.gets # ちゃんとスコープ別れるのだろうか?
          sp.puts line rescue exit 1
        end
      end
    end
  end
  
end

sp.close
