require 'socket'
require 'json'

class TinyWebBrowser
  def initialize
    @user = User.new
  end

  def start
    greeting

    path = file_path
    method = choose_method

    @socket = create_socket
    @socket.print request(method, path)
    puts response

    close_socket
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

  def file_path
    puts 'Please, enter the path to the file, which you want to get (for example: /path/to/file_name.html)'
    file_path = gets.chomp
    puts
    file_path
  end

  def choose_method
    puts 'Please, choose the method of your request'
    puts '1 - GET, 2 - POST'
    choice = gets.chomp.to_i
    puts

    if choice == 1
      'GET'
    elsif choice == 2
      'POST'
    end
  end

  def request(method, path)
    request = []

    request << "#{method} #{path} HTTP/1.1"
    request << "From: #{@user.email}"
    request << 'User-Agent: Tiny Web Browser'

    if method.upcase == 'POST'
      params = {:user => {:login => @user.login, :email => @user.email } }
      body = params.to_json

      request << 'Content-Type: personal info'
      request << "Content-Length: #{body.length}"

      request = request.join("\n")

      request << "\r\n\r\n"
      request << body
    else
      request = request.join("\n")
      request << "\r\n\r\n"
    end

    request
  end

  def response
    @socket.read
  end

  def close_socket
    @socket.close
  end
end

browser = TinyWebBrowser.new
browser.start