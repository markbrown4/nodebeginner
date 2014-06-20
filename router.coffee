_ = require "underscore"

route = (routes, pathName, request, response, params)->
  if typeof routes[pathName] == 'function'
    # direct match
    callAction routes[pathName], request, response, params
  else
    found = false
    for route, action of routes
      # find routes with dynamic segments
      routeRegex = route.replace /\./, "\." # escape '.'
      routeRegex = routeRegex.replace /:\w+/gi, "(.*?)" # make :param a capture group
      routeRegex = new RegExp "^#{ routeRegex }$"
      matches = pathName.match routeRegex
      if matches != null
        found = true
        namedParams = route.match(/:(\w+)?/ig)
        for param, i in namedParams
          params[param.substr(1)] = matches[i+1]

        callAction action, request, response, params

    unless found
      response.writeHead 404, { "Content-Type": "text/plain" }
      response.write "404 - Sheeyat!"
      response.end()

callAction = (action, request, response, params)->
  action.call
    request: request
    response: response
    params: params

module.exports.route = route
