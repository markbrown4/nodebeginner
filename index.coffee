server = require "./server"
router = require "./router"
routes = require "./app/routes"

server.start(router, routes)
