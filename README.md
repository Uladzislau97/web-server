# web-server
It is a ruby application, which models 'client-server' structure. 

Firstly in console start ```server.rb```. Then in other consoles run ```tiny_web_browser.rb```.

In this tiny web browser you can choose the method of http request and path to file, that you want to get.

Server contains _content/thanks.html_ file. Command ```POST /content.thanks.html HTTP/1.1``` returns you upgraded _thanks.html_, which now contains your login and email.