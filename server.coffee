_ = require "underscore"
http = require "http"
url = require "url"
querystring = require "querystring"
router = require "./router"

start = (routes)->
  server = http.createServer (request, response)->
    parsedURL = url.parse(request.url, true)
    pathName = parsedURL.pathname
    postData = ""
    params = parsedURL.query

    request.setEncoding "utf8"
    request.addListener "data", (chunk)->
      postData += chunk

    request.addListener "end", ->
      params = _.extend params, querystring.parse(postData)
      router.route routes, pathName, response, params

  server.listen 8888

  console.log "Server running at http://localhost:8888/"

module.exports.start = start
