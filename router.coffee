route = (routes, pathname, response, params)->
  if typeof routes[pathname] == 'function'
    routes[pathname].call response, params
  else
    response.writeHead 404, { "Content-Type": "text/plain" }
    response.write "404 - Sheeyat!"
    response.end()

module.exports.route = route
