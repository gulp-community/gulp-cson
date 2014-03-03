map = require 'map-stream'
coffee = require 'coffee-script'
rext = require 'replace-ext'
cson = require 'cson'

module.exports = (options) ->
  options = {} unless options

  gcson = (file, cb) ->
    data = cson.parseSync file.contents.toString 'utf8', options
    file.contents = new Buffer JSON.stringify data
    file.path = rext file.path, '.json'

    cb null, file

  return map gcson