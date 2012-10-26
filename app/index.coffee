require("lib/setup")

Spine       = require("spine")
Distillery  = require("controllers/distillery")

class App extends Spine.Controller
  constructor: ->
    super
    @distillery = new Distillery
    @append @distillery
    
module.exports = App