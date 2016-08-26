require 'socket'

class Server
  def initialize
    @port = 2000
    @server = TCPServer.open(@port)

    @content_types = {
        txt: 'text/plain',
        doc: 'text/plain',
        docx: 'text/plain',
        html: 'text/html',
        css: 'text/css',
        js: 'text/javascript',
        jpg: 'image/jpg',
        jpeg: 'image/jpeg',
        png: 'image/png',
        mp3: 'audio/mp3',
        mp4: 'video/mp4',
        avi: 'video/avi'
    }
  end

  def start
    loop {
      Thread.start(@server.accept) do |client|
        request = client.read_nonblock(256)

        show_request(request)

        client.puts response(request)

        client.close
      end
    }
  end

  private

  def response(request)
    if request_correct?(request)
      initial_line = request.split("\n")[0]

      method = initial_line.split(' ')[0]
      path = initial_line.split(' ')[1][1..-1]

      content_type = content_type(path)

      if File.exist?(path)
        content = File.read(path)

        response = []
        response << 'HTTP/1.1 200 OK'
        response << "Date: #{Time.now.asctime}"
        response << "Content-Type: #{content_type}"
        response << "Content-Length: #{content.length}"

        response = response.join("\n")

        response << "\r\n\r\n"
        response << content
      else
        "HTTP/1.1 404 Not Found\r\n\r\n"
      end
    else
      "HTTP/1.1 400 Bad Request\r\n\r\n"
    end
  end

  def show_request(request)
    puts
    puts '##### Request ############'
    puts request
    puts '##########################'
    puts
  end

  def content_type(path)
    format = path.split('.')[1]
    @content_types[format.to_sym]
  end

  def initial_line_correct?(line)
    line.scan(/^ *(?i)(GET|POST) (\/\w+)+(\.\w+) (HTTP\/1\.1) *$/).any?
  end

  def header_line_correct?(line)
    line.scan(/^ *[a-zA-Z]+(-[a-zA-Z]+)?: *.* *$/).any?
  end

  def header_lines_correct?(lines)
    lines.all? { |line| header_line_correct?(line) }
  end

  def request_correct?(request)
    request_header, request_body = request.split("\r\n\r\n", 2)
    request_lines = request_header.split("\n")
    initial_line = request_lines[0]
    header_lines = request_lines[1..-1]

    initial_line_correct?(initial_line) && header_lines_correct?(header_lines)
  end
end

server = Server.new
server.start