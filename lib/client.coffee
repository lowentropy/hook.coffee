{Hook} = require './hook'

hook = new Hook port: 3001
hook.start()

hook.on 'ready', ->
  hook.on 'greetings', (data) ->
    console.log 'server said greetings to', data
  hook.emit 'hello', 'dog'
