class UserStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_status_channel"
    logger.info "Subscribed to UserStatusChannel"

    @nicknames = "nicknames"
    $redis.rpush(@nicknames, current_user.nickname)
    notify
  end

  def unsubscribed
    logger.info "Unsubscribed to UserStatusChannel"

    $redis.lrem(@nicknames, 1, current_user.nickname)
    notify
  end

  def notify
    @online_users = $redis.lrange(@nicknames, 0, -1).uniq
    ActionCable.server.broadcast "user_status_channel", users: @online_users
  end
end
