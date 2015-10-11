var http = require('http');
var dns = require('dns');
var fs = require('fs');
var finalhandler = require('finalhandler');
var serveStatic = require('serve-static');

var contents = "var CONFIG = { apiHost: '" + process.env.API_HOST + "', apiPort: " + process.env.API_PORT + " };";
fs.writeFile(__dirname + '/public/js/config.js', contents, function(err) {
    if (err) {
        console.log('Error: ' + err);
    }
});

var serve = serveStatic(__dirname + '/public');

// Create server
var server = http.createServer(function(req, res) {
    var done = finalhandler(req, res);
    serve(req, res, done);
});

// Listen
server.listen(3000);
console.log('App started on port 3000');
