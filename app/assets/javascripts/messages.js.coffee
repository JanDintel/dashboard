source = new EventSource('/messages/events')

source.addEventListener 'message', (event) ->
  $('#messages tr:first').after($('<td>').text("#{event.data}"))
