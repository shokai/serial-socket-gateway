serial socket gateway
====================
serial device (/dev/tty.*.usbserial) <---> TCP Socket

* multi client support.
* each client can read/write.
* forwards strings from serial device to all socket clients.
* split by '\n'

Dependencies
============
* ruby-serialport (build from source code)
* eventmachine (rubygem)
* your serial device (arduino, mbed ...)


Install ruby-serialport
-----------------------

    % wget http://rubyforge.org/frs/download.php/72/ruby-serialport-0.6.tar.gz
    % tar -zxvf ruby-serialport-0.6.tar.gz
    % cd ruby-serialport-0.6
    % ruby extconf.rb
    % make
    % sudo make install

ruby-serialport 0.7 is not work.


Install eventmachine
--------------------

    % gem install eventmachine


Run
===

Connect serial device, then

    % ./serial-socket-gateway


Use
===

    % telnet localhost 8782


Make client using TCP Socket
============================
see "samples" directory.

    ## connect
    % require 'socket'
    % s = TCPSocket.open("192.168.1.100", 8782)

    ## write to serial device
    % s.puts "abc abc"

    ## receive
    % puts s.gets
 