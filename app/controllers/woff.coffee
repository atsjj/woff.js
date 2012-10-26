Spine     = require("spine")
jDataView = require("jParser/node_modules/jDataView/src/jdataview")
jParser   = require("jParser/src/jparser")

class Woff extends Spine.Module
  @include Spine.Log
  # @include TableDirectory
  # @include FontTables
  # @include ExtendedMetaData
  # @include PrivateData
  
  headerStructure:
    signature:      "uint32"
    flavor:         "uint32"
    length:         "uint32"
    numTables:      "uint16"
    reserved:       "uint16"
    totalSfntSize:  "uint32"
    majorVersion:   "uint16"
    minorVersion:   "uint16"
    metaOffset:     "uint32"
    metaLength:     "uint32"
    metaOrigLength: "uint32"
    privOffset:     "uint32"
    privLength:     "uint32"
    
  tableDirectoryStructure:
    tag:            "uint32"
    offset:         "uint32"
    compLength:     "uint32"
    origLength:     "uint32"
    origChecksum:   "uint32"
  
  fontDataTable: ->
    home = @tell()
    
    @seek @current.offset
    font = @parse ["string", @current.compLength]
    
    @seek home
    console.log(home, @tell())
    font

  
  constructor: (@buffer = new ArrayBuffer()) ->
    super
    view = new jDataView(event.target.result, undefined, undefined, false)
    
    @parser = new jParser view
    
    @header = @parser.parse(@headerStructure)
    @tableDirectory = @parser.parse(["array", @tableDirectoryStructure, @header.numTables])
    @tableDirectory.sort (a, b) ->
      a.offset < b.offset
    
    @log @header
    @log @tableDirectory
    @log @parser.tell()
    
module.exports = Woff