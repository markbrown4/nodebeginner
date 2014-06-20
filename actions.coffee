fs = require "fs"

index = ->
  body = """
  <!doctype html>
  <html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; '+ 'charset=UTF-8">
  </head>
  <body>
  <form action="/upload/yep?get=yep" method="post">
    <textarea name="post">yep</textarea>
    <input type="submit">
  </form>
  </body>
  </html>
  """
  @response.writeHead 200, { "Content-Type": "text/html" }
  @response.write body
  @response.end()

upload = ->
  @response.writeHead 200, { "Content-Type": "text/plain" }
  @response.write "You've sent: " + JSON.stringify(@params)
  @response.end()

show = ->
  fs.readFile "./test.png", "binary", (error, file)=>
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
