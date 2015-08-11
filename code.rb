<<-DOC

HTTP Challenge
--------------

* Define the common HTTP verbs
  - GET: Retrieve a resource
  - POST: Add a new resource
  - PUT/PATCH: Change an existing resource; PUT replaces the resource, while PATCH changes only part of it
  - DELETE: Remove an existing resource

* Use the tool of your choice to draw the HTTP request/response cycle.
  - include a link to your diagram, here

* Use telnet, curl, or ruby code to retrieve the messages at
  launch-academy-chat.herokuapp.com/messages

* Use telnet, curl, or ruby code to create a new message at
  launch-academy-chat.herokuapp.com/messages

  - Kernel::system method in ruby will allow you to execute command-line utilities such as curl.
  - other useful ruby libraries:
    * Net::HTTP
    * Net::Telnet

DOC

# code goes here
require 'net/http'
require 'open-uri'
require 'nokogiri'

DEFAULT_URL = 'http://launch-academy-chat.herokuapp.com/messages'

def get_response(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  return response
end

def post_message(message)
  system("curl --verbose -d content='#{message}' launch-academy-chat.herokuapp.com/messages")
end

def nokogiri_parse(url)
  page = Nokogiri::HTML(open(url))
  return page
end

def nokogiri_grab_messages(page)
  messages_raw_nodeset = page.css("div.pure-u-1-2")
  messages_raw_string = messages_raw_nodeset.text
  messages = []
  messages_raw_string.lines.each do |line|
    messages << line.strip if line.strip.length > 0
  end
  return messages
end

puts get_response(DEFAULT_URL)
#post_message("Always never forget to check your references")
#puts nokogiri_grab_messages(nokogiri_parse(DEFAULT_URL))[1..-1]
