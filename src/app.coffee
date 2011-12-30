# Create base server
connect = require 'connect'
app = connect.createServer()
app.use connect.static("#{__dirname}/../public")

# Add browserify bundle
browserify = require 'browserify'
bundle = browserify(__dirname + '/../lib/client.coffee')
app.use bundle

# Start hook.io
Hook = require('hook.io-webserver').Webserver
hook = new Hook name: 'server-dude', port: 3001
hook.start()

hook.on 'webserver::started', ->

  # Listen for the browser
  hook.on 'hello', (data) ->
    console.log 'browser said hello', data
    hook.emit 'greetings', 'stranger'

  # Start the web server
  app.listen 3000
  
  console.log 'Ready!'
