{Hook} = require './hook'
Chat = require './chat'
$ = require 'jquery'

hook = new Hook(port: 3001).start()

nick = ->
  str = $('#nick').val()
  if (str?.trim() ? '').length == 0 then 'anonymous' else str


hook.on 'chat.msg', (message) ->
  $('#messages').append "<li>#{message.nick}: #{message.text}</li>"


$ ->
  $('#message').keyup (e) ->
    if e.keyCode == 13
      hook.emit 'chat.msg',
        nick: nick(),
        text: $(this).val()
      $(this).val ''
