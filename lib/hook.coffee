dnode = require 'dnode'
EventEmitter = require('eventemitter2').EventEmitter2

class exports.Hook extends EventEmitter

  constructor: (@options) ->
    EventEmitter.call @,
      delimiter: '::'
      wildcard: true

  connect: ->
    @client ?= dnode
      message: (event, data) =>
        EventEmitter.prototype.emit.call @, event, data
      report: ->

    @client.connect @options.port ? 3000, (@remote, conn) =>
      clearInterval @reconnectionTimer
      conn.on 'end', =>
        @reconnectionTimer = setInterval (=> @connect()), 3000
      @emit 'ready'

  start: -> @connect()

  emit: (event, data) ->
    return if event == 'newListener'
    @remote?.message event, data
