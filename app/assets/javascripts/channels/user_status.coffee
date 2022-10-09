App.user_status = App.cable.subscriptions.create "UserStatusChannel",
  connected: ->
    console.log("Connected to UserStatusChannel")

  disconnected: ->
    console.log("Disconnected to UserStatusChannel")

  received: (data) ->
    console.log("Received message: #{data["nickname"]} #{data["status"]}")

    if data["status"] == "online" and !document.querySelector("[id='#{data["id"]}']")
      $("#online").append "<div id='#{data["id"]}'>#{data["nickname"]}</div>"

    if data["status"] == "offline"
      $("##{data["id"]}").remove()
