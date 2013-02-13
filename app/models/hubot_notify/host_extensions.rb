# Ensure that module is namespaced with plugin name
module HubotNotify
	# Example: Create new instance and class methods on Foreman's Host model
	module HostExtensions
	  extend ActiveSupport::Concern

	  included do
      require 'net/http'

		  #execute standard callbacks
		  #after_create :do_this
		  #after_destroy :do_that

		  #execute custom hooks
		  after_build :do_something_special_after_build
      before_provision :do_this_before_provision

		  def do_something_special_after_build
		    logger.info "Logging build started to IRC"
        # This is run when Build button is clicked - so doesn't fire on New Host
        uri = URI('http://ircbot:8080/hubot/irc')
        Net::HTTP.post_form(uri, 'message' => "Host build started: #{@host.name}")
		  end

		  def do_this_before_provision
		    logger.info "Logging build complete to IRC"
        # This actually seems to get run at the end...
        uri = URI('http://ircbot:8080/hubot/irc')
        Net::HTTP.post_form(uri, 'message' => "Host build complete: #{@host.name}")
		  end

		end

	#   module ClassMethods
	# 	  # ...
	# 	end

	# 	module InstanceMethods
	# 	  # ...
	# 	  def new_instance_method
	# 	    #
	# 	  end
	# 	  # or overwrite existing method
	# 	end

	end
end
