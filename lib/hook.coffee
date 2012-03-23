dnode = require 'dnode'
{EventEmitter2} = require 'eventemitter2'

class exports.Hook extends EventEmitter2

  constructor: (@options) ->
    EventEmitter2.call @, wildcard: true
  
  _client: ->
    @client ?= dnode
      message: (event, data) =>
        EventEmitter2::emit.call @, event, data

  connect: ->
    port = @options.port ? 3000
    time = @options.reconnectInterval ? 3000
    @_client().connect port, {reconnect: time}, (@remote) =>
      @emit 'browser.ready'
    this

  start: -> @connect()

  emit: (event, data) ->
    return if event == 'newListener'
    @remote?.message event, data
    EventEmitter2::emit.call @, event, data
