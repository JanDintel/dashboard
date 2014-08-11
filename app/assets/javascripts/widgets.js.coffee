log = (message) ->
  console.log message

$ ->
  $(".gridster ul").gridster
    widget_margins: [10,10]
    widget_base_dimensions: [140, 140]
    draggable:
      stop: (event, ui) ->
              console.log "Serialized gridster:"
              console.log $(".gridster ul").gridster().data('gridster').serialize()

  gridster = $(".gridster ul").gridster().data('gridster')

  log "hello hello"
  log gridster.serialize()
