connect = require 'connect'
{Webhook} = require './webhook'

module.exports = class HookServer extends Webhook
  
  constructor: (opts) ->
    super opts
    @app = connect.createServer()
    @bundle = require('browserify')()
    # @app.use connect.static("#{__dirname}/../public")
    # bundle.register '.eco', require('../lib/eco')
    @bundle.require jquery: "#{__dirname}/../node_modules/jquery-browserify"
    #@bundle.addEntry "#{__dirname}/../lib/client.coffee"
    @app.use @bundle
    @on 'webserver::started', =>
      @app.listen 3000
  
  use: ->
    @app.use.apply @app, arguments
  
  register: ->
    @bundle.register.apply @bundle, arguments

  addEntry: ->
    @bundle.addEntry.apply @bundle, arguments