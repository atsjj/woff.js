Spine = require("spine")

class Woff extends Spine.Module
  @include Header
  @include TableDirectory
  @include FontTables
  @include ExtendedMetaData
  @include PrivateData
  
  @buffer: []
  
  constructor:
    super
  
class Header
  signature: ->
    (@buffer[0] << 16) + @buffer[1]
  
  isSignatureValid: ->
    @signature === 0x774F4646
  
  flavor: ->
    (@buffer[2] << 16) + @buffer[3]
  
class TableDirectory
  
class FontTables
  
class ExtendedMetaData
  
class PrivateData
  
module.exports = Woff