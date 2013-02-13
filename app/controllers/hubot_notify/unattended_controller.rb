module HubotNotify
  class UnattendedController < ::UnattendedController

    def unattended_local
      logger.info "Overriding UnattendedController in HubotNotify"
      super
    end

  end
end
