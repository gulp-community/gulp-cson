map = require 'map-stream'
coffee = require 'coffee-script'
rext = require 'replace-ext'
cson = require 'cson'

module.exports = (options) ->
  options = {} unless options

  gcson = (file, cb) ->
    cson.parse file.contents.toString(), options, (err, data) ->
      return cb err if err?
      file.contents = new Buffer JSON.stringify data
      file.path = rext file.path, '.json'

      cb null, file

  return map gcson
