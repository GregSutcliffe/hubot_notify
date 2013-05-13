class Setting::HubotNotify < ::Setting

  def self.load_defaults
    # Check the table exists
    return unless Setting.table_exists?
    return unless super

    Setting.transaction do
      [
        self.set('irc_enabled', "Whether to send notifications to IRC", true ),
        self.set('irc_address', "The address to send IRC notifications to", "http://myircserver:8080/hubot/irc" ),
        self.set('irc_user', "The user to notify", "ircuser" ),
        self.set('irc_room', "The room to notify", "#ircroom" ),
      ].compact.each { |s| self.create s.update(:category => "Setting::HubotNotify")}
    end

    true

  end

end
