require 'hubot_notify'

module HubotNotify
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inhereits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    # Include extensions to models in this config.to_prepare block
    config.to_prepare do
      return unless TemplateKind.table_exists?
      ::UnattendedController.send :include, HubotNotify::UnattendedControllerExtensions
    end

    initializer 'hubot_notify.load_default_settings', :before => :load_config_initializers do |app|
      require_dependency File.expand_path("../../../app/models/setting/hubot_notify.rb", __FILE__)
    end

#    config.after_initialize do
#      next unless Setting.table_exists?
 #     Setting::HubotNotify.load_defaults
    #end

  end
end
