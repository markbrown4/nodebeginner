upload = require "./controllers/upload_controller"

routes =
  "/": upload.index
  "/upload/file": upload.file
  "/upload/:route_segment": upload.post
  "/show": upload.show

module.exports = routes