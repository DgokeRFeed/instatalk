App.user_status = App.cable.subscriptions.create "UserStatusChannel",
  connected: ->
    console.log("Connected to UserStatusChannel")

  disconnected: ->
    console.log("Disconnected to UserStatusChannel")

  received: (data) ->
    console.log("Received message: #{data["users"]}")
    users = data["users"].map (user) -> "<div>#{user}</div>"
    $("#online").html(users.join(""))
