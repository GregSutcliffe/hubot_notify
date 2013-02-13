# Ensure that module is namespaced with plugin name
module HubotNotify
	# Example: Create new instance and class methods on Foreman's Host model
	module HostExtensions
	  extend ActiveSupport::Concern

	  included do
		  #execute standard callbacks
		  #after_create :do_this
		  #after_destroy :do_that

		  #execute custom hooks
		  after_build :do_something_special_after_build
      before_provision :do_this_before_provision

		  def do_something_special_after_build
		    logger.info "doing customized callback something special AFTER build"
		  end

		  def do_this_before_provision
		  	logger.info "doing this before provision"
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
	# end
end
