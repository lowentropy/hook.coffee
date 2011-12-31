{Hook} = require './hook'
Chat = require './chat'
$ = require 'jquery'

hook = new Hook(port: 3001).start()

hook.on 'chat::message', (message) ->
  $('#messages').append "<li>#{message}</li>"

$ ->
  $('#message').keyup (e) ->
    if e.keyCode == 13
      hook.emit 'chat::message', $(this).val()
      $(this).val ''
