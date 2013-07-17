// Generated by CoffeeScript 1.6.3
(function() {
  var http, root, start, url;

  http = require("http");

  url = require("url");

  start = function(route, handle) {
    var onRequest;
    onRequest = function(request, response) {
      var pathname;
      pathname = url.parse(request.url).pathname;
      console.log("Request for " + pathname);
      route(handle, pathname, response, request);
    };
    http.createServer(onRequest).listen(8888);
    console.log("Server started");
  };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.start = start;

}).call(this);