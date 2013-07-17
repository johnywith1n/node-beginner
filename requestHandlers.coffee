querystring = require "querystring"
fs = require "fs"
formidable = require "formidable"

start = (response, request) ->
  console.log "Request handler 'start' was called"

  body = '<html>'+
    '<head>'+
    '<meta http-equiv="Content-Type" '+
    'content="text/html; charset=UTF-8" />'+
    '</head>'+
    '<body>'+
    '<form action="/upload" enctype="multipart/form-data" '+
    'method="post">'+
    '<input type="file" name="upload" multiple="multiple">'+
    '<input type="submit" value="Upload file" />'+
    '</form>'+
    '</body>'+
    '</html>';

  response.writeHead 200, {"Content-type" : "text/html"}
  response.write body
  response.end()
  return

upload = (response, request) ->
  console.log "Request handler 'upload' was called"
  form = new formidable.IncomingForm()
  console.log "about to parse"
  form.parse request, (error, fields, files) ->
    console.log "parsing done"
    fs.rename files.upload.path, "/tmp/test.png", (error) ->
      if error
        fs.unlink "/tmp/test.png"
        fs.rename files.upload.path, "/tmp/test.png"
      return
    return
  response.writeHead(200, {"Content-Type": "text/html"})
  response.write("received image:<br/>")
  response.write("<img src='/show' />")
  response.end()
  return

show = (response, request) ->
  console.log "Request handler 'show' was called."
  fs.readFile "/tmp/test.png", "binary", (error, file) ->
    if error
      response.writeHead 500, {"Content-Type" : "text/plain"}
      response.write error + "\n"
      response.end()
    else
      response.writeHead 200, {"Content-Type" : "image/png"}
      response.write file, "binary"
      response.end()
    return
  return

root = exports ? this
root.start = start
root.upload = upload
root.show = show