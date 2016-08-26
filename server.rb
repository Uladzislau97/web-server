require 'socket'

class Server
  def initialize
    @port = 2000
    @server = TCPServer.open(@port)
  end

  def start
    loop {
      Thread.start(@server.accept) do |client|
        request = client.read_nonblock(256)
        request_header, request_body = request.split("\r\n\r\n", 2)

        initial_line = request_header.split("\n").fetch(0)

        client.close
      end
    }
  end

  private

  def initial_line_correct?(line)
    line.scan(/^ *(?i)(GET|POST) (\/\w+)+(\.\w+) (HTTP\/)(2\.0|1\.[10]) *$/).any?
  end

  
end

server = Server.new
server.start