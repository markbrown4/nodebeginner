_ = require "underscore"
http = require "http"
url = require "url"
querystring = require "querystring"
formidable = require "formidable"
router = require "./router"

start = (routes)->
  server = http.createServer (request, response)->
    parsedURL = url.parse request.url, true
    if request.method == 'GET'
      router.route routes, parsedURL.pathname, request, response, parsedURL.query
    else
      # let formidable handle POST submissions
      form = new formidable.IncomingForm()
      form.parse request, (err, fields, files)->
        for name, file of files
          files[name] = null if file.size == 0
        # merge GET, POST and files
        params = _.extend parsedURL.query, fields
        params = _.extend params, files
        router.route routes, parsedURL.pathname, request, response, params

  server.listen 8888
  console.log "Server running at http://localhost:8888/"

module.exports.start = start
