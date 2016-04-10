map = require 'map-stream'
coffee = require 'coffee-script'
rext = require 'replace-ext'
cson = require 'cson'

module.exports = (options) ->
  options = {} unless options
  indent = if typeof options.indent == 'string' or options.indent == null then options.indent else '  '

  gcson = (file, cb) ->
    json = cson.parse file.contents.toString(), options
    return cb json if json instanceof Error
    file.contents = new Buffer JSON.stringify json, null, indent
    file.path = rext file.path, '.json'

    cb null, file

  return map gcson
