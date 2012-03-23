# Create http server
express = require 'express'
app = express.createServer()
app.use express.static("#{__dirname}/../public")

# Add browserify bundle
bundle = require('browserify')()
bundle.register '.eco', require('../lib/eco')
bundle.require jquery: 'jquery-browserify'
bundle.addEntry "#{__dirname}/../lib/client.coffee"
app.use bundle

# Start hook.io
#Hook = require('hook.io-webserver').Webserver
Hook = require('./webhook').Webhook
hook = new Hook name: 'server-dude', port: 3001
hook.start()

# Start the web server
hook.on 'webserver.started', ->
  hook.on 'STDIN', (text) ->
    hook.emit 'chat.msg',
      nick: 'STDIN'
      text: text
  app.listen 3000
