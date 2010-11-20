serial socket gateway
====================
serial device (/dev/tty.*.usbserial) <---> TCP Socket

* multi client support.
* each client can read/write.
* forwards strings from serial device to all socket clients.
* split by '\n'
* testing on Mac, Linux and Windows.

Dependencies
============
* ruby-serialport (build from source code)
* eventmachine, ArgsParser (rubygem)
* your serial device (arduino, mbed ...)


Install ruby-serialport
-----------------------

install ruby-serialport 0.6.0. Not work on 0.7.

for Mac OSX and Ubuntu 9.04, 10.04

    % wget http://rubyforge.org/frs/download.php/72/ruby-serialport-0.6.tar.gz
    % tar -zxvf ruby-serialport-0.6.tar.gz
    % cd ruby-serialport-0.6
    % ruby extconf.rb
    % make
    % sudo make install

for Windows (ActiveScriptRuby), download and decompress zip http://rubyforge.org/tracker/download.php/61/321/9924/1800/ruby-serialport-0.6.0-mswin32-gem.zip

    % gem install pkg/serialport-0.6.0-mswin32.gem


Install gems
------------

    % gem install eventmachine ArgsParser


Run
===

Connect serial device, then

    % ./serial-socket-gateway /dev/tty.your-usbdevice

or

    % ./serial-socket-gateway COM1


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

    ## read
    % puts s.gets
 