http = require "http"
url = require "url"

start = (route, handle) ->
    onRequest = (request, response) ->
        pathname = url.parse(request.url).pathname
        console.log "Request for " + pathname

        route handle, pathname, response, request
        return

    http.createServer(onRequest).listen(8888)
    console.log "Server started"
    return

root = exports ? this
root.start = start