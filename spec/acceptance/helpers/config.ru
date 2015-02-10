require 'thin'

app = proc do |env|
  # Response body has to respond to each and yield strings
  # See Rack specs for more info: http://rack.rubyforge.org/doc/files/SPEC.html
  body = ['hi!']

  [
    200,                                        # Status code
    { 'Content-Type' => 'text/html' },          # Reponse headers
    body                                        # Body of the response
  ]
end

run app
