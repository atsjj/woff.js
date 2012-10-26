Spine = require("spine")
$     = Spine.$

class Distillery extends Spine.Controller
  className: "distillery"

  constructor: ->
    super
    @active @render()

  events:
    "change input[type=file]": "changed"

  changed: (event) ->
    @log "Distillery::changed"
    
    fileList = event.target.files[0]
    stream = new FileReader()
    stream.onload = ((file) ->
      (
        (e) ->
          new Uint16Array e.target.result
      )
    )(fileList)

    @buffer = stream.readAsArrayBuffer(fileList)
    
    @log @buffer

  render: ->
    @html require("views/distillery")(@)

module.exports = Distillery