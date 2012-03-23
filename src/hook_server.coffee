express = require 'express'
{Webhook} = require './webhook'

module.exports = class HookServer extends Webhook
  
  constructor: (opts) ->
    browserify = opts.browserify
    delete opts.browserify
    super opts
    @app = express.createServer()
    @bundle = require('browserify')(browserify ? {})
    @app.use @bundle
    @on 'webserver.started', =>
      @app.listen 3000
