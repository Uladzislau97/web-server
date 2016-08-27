require 'socket'

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)

request_header = "GET /content/index.html HTTP/1.1\nsomething: 788 fefe fefe\r\n\r\n45454444"

s.print request_header

while line = s.gets
  puts line.chop
end
s.close