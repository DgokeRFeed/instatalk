App.user_status = App.cable.subscriptions.create "UserStatusChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log("Connected to UserStatusChannel")

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log("Disconnected to UserStatusChannel")

  received: (data) ->
    # Called when there"s incoming data on the websocket for this channel
    console.log("Received message: #{data["nickname"]} #{data["status"]}")

    if data["status"] == "online" and !document.querySelector("[id='#{data["id"]}']")
      $("#online").append "<div id='#{data["id"]}'>#{data["nickname"]}</div>"

    if data["status"] == "offline"
      $("##{data["id"]}").remove()
