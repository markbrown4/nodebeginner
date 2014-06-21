server = require "./server"
uploadController = require "./app/controllers/upload_controller"

server.start
  "/": uploadController.index
  "/upload/file": uploadController.file
  "/upload/:route_segment": uploadController.post
  "/show": uploadController.show
