class UserStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_status_channel"
    logger.info "Subscribed to UserStatusChannel"

    current_user.update(online: true)
    notify("online")
  end

  def unsubscribed
    logger.info "Unsubscribed to UserStatusChannel"

    if connections_count == 0
      current_user.update(online: false)
      notify("offline")
    end
  end

  def notify(status)
    ActionCable.server.broadcast "user_status_channel",
                                 id: current_user.id,
                                 nickname: current_user.nickname,
                                 status: status
  end

  private

  def connections_count
    ActionCable.server.connections.count { |connection| connection.current_user == current_user }
  end
end
