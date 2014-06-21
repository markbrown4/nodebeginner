fs = require "fs"

index = ->
  fs.readFile './app/views/upload/index.html', (err, body)=>
    throw err if err
    @response.writeHead 200, { "Content-Type": "text/html" }
    @response.write body
    @response.end()

post = ->
  @response.writeHead 200, { "Content-Type": "text/plain" }
  @response.write "You've sent: " + JSON.stringify(@params)
  @response.end()

file = ->
  # move uploaded image to /tmp
  if @params.image
    fs.rename @params.image.path, "./tmp/test.png"

  @response.writeHead 200, { "Content-Type": "text/html" }
  @response.write '<img src="/show">'
  @response.end()

show = ->
  fs.readFile "./tmp/test.png", "binary", (error, file)=>
    if error
      @response.writeHead 500, { "Content-Type": "text/plain" }
      @response.write "#{error}\n"
      @response.end()
    else
      @response.writeHead 200, { "Content-Type": "image/png" }
      @response.write file, "binary"
      @response.end()

module.exports =
  index: index
  post: post
  file: file
  show: show
