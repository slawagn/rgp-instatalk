App.users_online = App.cable.subscriptions.create "UsersOnlineChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('Connected to UsersOnline channel')

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log('Disconnected from UsersOnline channel')

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log('Received action: ' + data['action'])

    if data['action'] == 'append'
      received_id = $(data['content'])[0].id
      if $('#' + received_id).length == 0
        $('#users_online').append $(data['content'])
    
    if data['action'] == 'remove'
      $(data['id']).remove()
