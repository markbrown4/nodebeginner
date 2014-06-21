fs = require "fs"

index = ->
  fs.readFile './app/views/upload/index.html', (err, body)=>
    throw err if err
    @response.writeHead 200, { "Content-Type": "text/html" }
    @response.write body
    @response.end()

upload = ->
  @response.writeHead 200, { "Content-Type": "text/plain" }
  @response.write "You've sent: " + JSON.stringify(@params)
  @response.end()

show = ->
  fs.readFile "./public/test.png", "binary", (error, file)=>
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
  upload: upload
  show: show