# Ensure that module is namespaced with plugin name
module HubotNotify
  # Example: Create new instance and class methods on Foreman's Host model
  module UnattendedControllerExtensions
    extend ActiveSupport::Concern

    included do
      after_filter :hubot_unattended, :only => [:provision,:finish]

      private

      def hubot_unattended
        logger.debug "Extending UnattendedController in HubotNotify#hubot_unattended"
        uri = URI('http://ircbot:8080/hubot/irc')
        Net::HTTP.post_form(uri, 'message' => "#{params['action'].capitalize} template requested: #{@host.name}")
      end

    end
  end
end
