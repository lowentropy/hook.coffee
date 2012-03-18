HookServer = require './hook_server'

exports.Hook = require('./webhook').Webhook
exports.HookServer = HookServer
exports.eco = require('../lib/eco')
exports.ClientHook

exports.server = (opts={}) ->
  opts.name ?= 'server'
  opts.port ?= 3001
  hook = new HookServer opts
  hook.start()
  hook
