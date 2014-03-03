fs = require "fs"
path = require "path"
should = require "should"
gutil = require "gulp-util"
gcson = require "../"

require "mocha"

describe "gulp-cson", ->
  it "should parse cson to json", (done) ->
    myFunction = gcson()
    fakeFile = new gutil.File
      base: "test/fixtures"
      cwd: "test/"
      path: "test/fixtures/normal.cson"
      contents: fs.readFileSync path.join __dirname, "/fixtures/normal.cson"
    
    myFunction.once "data", (newFile) ->
      should.exist newFile
      should.exist newFile.contents
      String(newFile.contents).should.equal String fs.readFileSync path.join __dirname, "/expected/normal.json"
      done()

    myFunction.write fakeFile
