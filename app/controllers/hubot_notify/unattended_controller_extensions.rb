# Ensure that module is namespaced with plugin name
module HubotNotify
  # Example: Create new instance and class methods on Foreman's Host model
  module UnattendedControllerExtensions
    extend ActiveSupport::Concern

    included do
      after_filter :hubot_unattended, :only => [:provision,:finish,:built]

      private

      def hubot_unattended
        logger.debug "Extending UnattendedController in HubotNotify#hubot_unattended"

        if params['action'] == 'built'
          message = "Host build complete"
        else
          message = "#{params['action'].capitalize} template requested"
        end

        uri = URI('http://ircbot:8080/hubot/irc')
        Net::HTTP.post_form(uri, 'message' => "#{@host.name}: #{message}")
      end

    end
  end
end
