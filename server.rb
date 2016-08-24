require 'socket'               # Get sockets from stdlib

server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {                         # Servers run forever
  client = server.accept       # Wait for a client to connect

  request = client.read
  request_parts = request.scan(/(?i)(GET|POST) (((\/\w+)*)(\.\w+)) (HTTP\/[12]\.[01])/)

  p request_parts

  if request_parts.empty?
    puts 'Wrong HTTP request.'
  else
    method = request_parts[0]
    file = request_parts[1]

    if method.upcase == 'GET'

    elsif method.upcase == 'POST'

    end
  end

  #client.puts(Time.now.ctime)  # Send the time to the client
  #client.puts 'Closing the connection. Bye!'
  client.close                 # Disconnect from the client
}
