route = (routes, pathName, request, response, params)->
  if typeof routes[pathName] == 'function'
    # direct match
    callAction routes[pathName], request, response, params
  else
    found = false
    for route, action of routes
      # find routes with dynamic segments
      regex = route.replace /\./, "\." # escape '.'
      regex = regex.replace /:\w+/gi, "(.*?)" # make :param a capture group
      regex = new RegExp "^#{ regex }$"
      matches = pathName.match regex
      if matches != null
        found = true
        namedParams = route.match(/:(\w+)?/ig)
        for param, i in namedParams
          params[param.substr(1)] = matches[i+1]

        callAction action, request, response, params
        break

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
