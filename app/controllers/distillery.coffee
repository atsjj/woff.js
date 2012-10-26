jDataView = require("jParser/node_modules/jDataView/src/jdataview")
jParser   = require("jParser/src/jparser")
Spine     = require("spine")
Woff      = require("controllers/woff")
$         = Spine.$

jQuery.event.props.push("dataTransfer");

class Distillery extends Spine.Controller
  buffer: null
  className: "distillery"
  events:
    "dragenter #kettle": "dragging"
    "dragover #kettle": "dragged"
    "drop #kettle": "dropped"

  constructor: ->
    super
    @active @render()
  
  kill: (event) ->
    event.stopPropagation()
    event.preventDefault()
  
  dragging: (event) ->
    @kill event
    @log "Distillery::dragging", event
  
  dragged: (event) ->
    @kill event
    @log "Distillery::dragged", event
    
  dropped: (event) ->
    @kill event
    @log "Distillery::dropped", event
    
    file = event.dataTransfer.files[0]
    return false unless file.type is "application/x-font-woff"
    
    stream = new FileReader()
    stream.addEventListener "load", @proxy @buffering
    stream.readAsArrayBuffer(file)
    
  buffering: (event) ->
    @log "Distillery::buffering", event
    @buffer = new Woff(event.target.result)

  render: ->
    @html require("views/distillery")(@)

module.exports = Distillery