class UsersOnlineChannel < ApplicationCable::Channel
  def subscribed
    logger.info 'Subscribed to UsersOnline channel'
    
    stream_from "users_online_channel"

    current_user.update(online: true)
    
    ActionCable.server.broadcast 'users_online_channel', {
      action: 'append',
      content: ApplicationController.renderer.render(
        partial: 'users/user',
        locals:  {
          user: current_user
        })
    }
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    logger.info 'Unsubscribed from UsersOnline channel'

    current_user.update(online: false)
    
    ActionCable.server.broadcast 'users_online_channel', {
      action: 'remove',
      id: "#user#{current_user.id}"
    }
  end
end
