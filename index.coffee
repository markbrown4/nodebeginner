server = require "./server"
actions = require "./actions"

server.start
  "/": actions.index
  "/upload": actions.upload
  "/show": actions.show
