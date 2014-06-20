fs = require "fs"

index = (params)->
  body = """
  <!doctype html>
  <html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; '+ 'charset=UTF-8">
  </head>
  <body>
  <form action="/upload?get=yep" method="post">
    <textarea name="post">yep</textarea>
    <input type="submit">
  </form>
  </body>
  </html>
  """
  @writeHead 200, { "Content-Type": "text/html" }
  @write body
  @end()

upload = (params)->
  @writeHead 200, { "Content-Type": "text/plain" }
  @write "You've sent: " + JSON.stringify(params)
  @end()

show = (params)->
  fs.readFile "./test.png", "binary", (error, file)=>
    if error
      @writeHead 500, { "Content-Type": "text/plain" }
      @write "#{error}\n"
      @end()
    else
      @writeHead 200, { "Content-Type": "image/png" }
      @write file, "binary"
      @end()

module.exports =
  index: index
  upload: upload
  show: show
