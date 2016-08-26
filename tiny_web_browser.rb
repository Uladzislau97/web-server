require 'socket'

#path = '/content/index.htm'

#request = "GET #{path} HTTP/1.0\r\n\r\n"


#socket.print(request)
#response = socket.read

#headers,body = response.split("\r\n\r\n", 2)
#print body

class TinyWebBrowser
  def initialize
    @socket = create_socket
    @user = User.new
  end

  def start

  end

  private

  class User
    attr_reader :login, :email

    def initialize
      puts
      puts 'Please, enter your login and email'
      print 'Login: '
      @login = gets.chomp
      print 'Email: '
      @email = gets.chomp
      puts
    end
  end

  def create_socket
    host = 'localhost'
    port = 2000

    TCPSocket.open(host,port)
  end

  def greeting
    puts "Hello! Welcome to our browser, #{@user.login}"
    puts
  end

  #def choose_method
  #  puts 'Please, choose the method of your request'
  #end
end