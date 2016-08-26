require 'socket'

#path = '/content/index.htm'

#request = "GET #{path} HTTP/1.0\r\n\r\n"


#socket.print(request)
#response = socket.read

#headers,body = response.split("\r\n\r\n", 2)
#print body

class TinyWebBrowser
  def initialize
    host = 'localhost'
    port = 2000
    @socket = TCPSocket.open(host,port)
  end

  private

  def initialization_of_user
    puts
    puts 'Please, enter your login and email'
    print 'Login: '
    @login = gets.chomp
    print 'Email: '
    @email = gets.chomp
    puts
    puts "Welcome to our browser, #{@login}"
  end
end