server = require "./server"
actions = require "./actions"

server.start
  "/": actions.index
  "/upload/:route_segment": actions.upload
  "/show": actions.show
