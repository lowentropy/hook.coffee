{Hook} = require 'hook.io'
http   = require 'http'
dnode  = require 'dnode'

class exports.Webhook extends Hook
  
  constructor: (options) ->
    Hook.call @, options
    @host ?= '127.0.0.1'
    @clients = {}
    @_id = 0
    
    @on 'hook.started', =>
      @findPort port: @port, (err, port) =>
        @port = port
        @_start_server()
  
  emit: (event, data, callback) ->
    for id, client of @clients
      client.message event, data, callback
    Hook::emit.call @, event, data, callback
  
  _emit_from: (from, event, data, callback) ->
    for id, client of @clients
      continue if id == from
      client.message event, data, callback
    Hook::emit.call @, event, data, callback
  
  _dnode: ->
    dnode (client, conn) =>
      @clients[id = '' + @_id++] = client
      conn.on 'end', => delete @clients[id]
      message: (event, data, callback) =>
        @_emit_from id, event, data, callback

  _start_server: ->
    web = http.createServer()
    @_dnode().listen web
    web.listen @port, =>
      @emit 'webserver.started', @port
