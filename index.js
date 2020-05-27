const map = require("map-stream");
const rext = require("replace-ext");
const cson = require("cson");

module.exports = function (options) {
  if (!options) {
    options = {};
  }
  const indent =
    typeof options.indent === "string" || options.indent === null
      ? options.indent
      : "  ";
  const gcson = function (file, cb) {
    const json = cson.parse(file.contents.toString(), options);
    if (json instanceof Error) {
      return cb(json);
    }
    file.contents = new Buffer(JSON.stringify(json, null, indent));
    file.path = rext(file.path, ".json");
    return cb(null, file);
  };
  return map(gcson);
};
