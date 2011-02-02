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
* serialport, eventmachine, ArgsParser (rubygem)
* your serial device (arduino, mbed ...)


Install gems
------------

    % gem install eventmachine serialport ArgsParser


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
 
