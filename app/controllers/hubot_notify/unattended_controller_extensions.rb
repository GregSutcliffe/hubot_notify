# Ensure that module is namespaced with plugin name
module HubotNotify
  # Example: Create new instance and class methods on Foreman's Host model
  module UnattendedControllerExtensions
    extend ActiveSupport::Concern

    included do
      after_filter :hubot_unattended, :only => [:provision,:finish]

      private

      def hubot_unattended
        logger.info "foo: #{params.inspect}"
        logger.info "Unattended script requested: #{@host.name}"
      end

    end
  end
end
