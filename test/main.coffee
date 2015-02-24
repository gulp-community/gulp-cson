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
      should.equal newFile.path, 'test/fixtures/normal.json'
      String(newFile.contents).should.equal String fs.readFileSync path.join __dirname, "/expected/normal.json"
      done()

    myFunction.write fakeFile

  it "should return error on error", (done) ->
    myFunction = gcson()
    fakeFile = new gutil.File
      base: "test/fixtures"
      cwd: "test/"
      path: "test/fixtures/normal.cson"
      contents: fs.readFileSync path.join __dirname, "/fixtures/error.cson"

    myFunction.once "error", (err) ->
      should.exist err
      should.equal String(err.message), "[stdin]:12:1: error: unmatched }\n\u001b[1;31m}\u001b[0m\n\u001b[1;31m^\u001b[0m"

      done()

    myFunction.write fakeFile
