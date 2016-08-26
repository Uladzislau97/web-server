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

  def header_line_correct?(line)
    line.scan(/^ *[a-zA-Z]+(-[a-zA-Z]+)?: *.* *$/).any?
  end

  def header_lines_correct?(lines)
    lines.inject(false) { |result, line| result && header_line_correct?(line) }
  end

  def request_correct?(request)
    request_header, request_body = request.split("\r\n\r\n", 2)
    request_lines = request_header.split("\n")
    initial_line = request_lines[0]
    header_lines = request_header[1..-1]

    initial_line_correct?(initial_line) && header_lines_correct?(header_lines)
  end
end

server = Server.new
server.start