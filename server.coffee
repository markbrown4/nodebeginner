_ = require "underscore"
http = require "http"
url = require "url"
querystring = require "querystring"
router = require "./router"

start = (routes)->
  server = http.createServer (request, response)->
    postData = ""

    request.setEncoding "utf8"
    request.addListener "data", (chunk)->
      postData += chunk

    request.addListener "end", ->
      parsedURL = url.parse(request.url, true)
      params = _.extend parsedURL.query, querystring.parse(postData)
      router.route routes, parsedURL.pathname, request, response, params

  server.listen 8888
  console.log "Server running at http://localhost:8888/"

module.exports.start = start
