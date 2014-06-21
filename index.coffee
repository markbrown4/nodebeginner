server = require "./server"
uploadController = require "./app/controllers/upload_controller"

server.start
  "/": uploadController.index
  "/upload/:route_segment": uploadController.upload
  "/show": uploadController.show
