_          = require('underscore')
characters = require('./characters')

class App
  baseurl  : "http://api.adorable.io/avatar/"
  sizexurl : "180"
  sizeyurl : "180"
  nameurl  : "abott@adorable.png"
  maxsize  : 400
  tmpValue : ''

  constructor: ->
    @_handleInputEvent = _.throttle @handleInputEvent, 300
    @_flash = _.debounce @flash, 300
    @setupEvents()

  setupEvents: ->
    $('input').on 'input', @_handleInputEvent
    $('#png').on 'change', @handleInputEvent

  handleInputEvent: (e) =>
    $el = $(e.target)
    $for = $($el.data('for'))

    # If Checkbox
    return @setExtension(e, $for) if e.target.type == 'checkbox'

    # Otherwise
    value = $(e.target).val()
    @[e.target.id + 'url'] = value
    $for.text(value)
    @_flash($for)
    @setURL()


  flash: ($for) ->
    $for.addClass('flash')
    setTimeout (-> $for.removeClass('flash')), 600

  processCharacter: (e) ->
    if $(e.target).hasClass('num')
      if not characters.isNumber(e.keyCode)
        e.preventDefault()

  setExtension: (e, $for) -> $for.toggle(e.target.checked)

  setURL: ->
    url = "#{@baseurl}#{@sizexurl}x#{@sizexurl}/#{@nameurl}"
    $('#demo-image').attr('src', url)

module.exports = new App()
