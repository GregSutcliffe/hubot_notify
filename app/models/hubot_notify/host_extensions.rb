require 'net/http'

# Ensure that module is namespaced with plugin name
module HubotNotify
	# Example: Create new instance and class methods on Foreman's Host model
	module HostExtensions
	  extend ActiveSupport::Concern

	  included do

		  #execute custom hooks
      before_provision :notify_on_built

		  def notify_on_built
        # This actually seems to get run at the end... despite being called 'before'
		    logger.info "Logging build complete to IRC from host"
        #uri = URI('http://ircbot:8080/hubot/irc')
        #Net::HTTP.post_form(uri, 'message' => "Host build complete: #{@host.name}")
		  end

		end

	end
end
