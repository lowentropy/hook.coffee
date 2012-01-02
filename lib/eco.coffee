module.exports = (body, file) ->
  idx = file.indexOf 'templates'
  [parts..., name] = file.substring(idx + 10).split '/'
  name = name.substring(0, name.length - 4)
  content = require('eco').precompile body
  str = "module.exports = #{content}; container = window.JST = (window.JST || {});"
  for key in parts
    str += "container = container['#{key}'] = container['#{key}'] || {};"
  str += "container['#{name}'] = module.exports;"
  str
