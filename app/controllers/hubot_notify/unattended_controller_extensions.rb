# Ensure that module is namespaced with plugin name
module HubotNotify
  # Example: Create new instance and class methods on Foreman's Host model
  module UnattendedControllerExtensions
    extend ActiveSupport::Concern

    included do
      after_filter :hubot_unattended, :only => [:provision,:finish,:built]

      private

      def hubot_unattended
        # params['spoof'] has already been deleted/consumed by
        # UnattendedController so check against fullpath instead
        return if request.fullpath.match /\?spoof=/

        if params['action'] == 'built'
          message = "Host build complete, available on #{request.env['REMOTE_ADDR']}"
        else
          message = "#{params['action'].capitalize} template requested"
        end

        post_data = {
          'user'    => (Setting[:irc_user] || 'ircuser'),
          'room'    => (Setting[:irc_room] || '#ircroom'),
          'message' => "#{@host.name}: #{message}"
        }

        if Setting[:irc_enabled]
          address = Setting[:irc_address] || 'http://ircbot/hubot'
          logger.debug "Sending message to #{address}"
          begin
            Net::HTTP.post_form(URI(address), post_data)
          rescue Errno::ECONNREFUSED
            logger.info "Connection refused from #{address}"
          rescue => e
            puts e.class
            puts e.message
            puts e.backtrace
          end
        end
      end

    end
  end
end
