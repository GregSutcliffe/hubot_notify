require 'net/http'

# Ensure that module is namespaced with plugin name
module HubotNotify
  class UnattendedController < ApplicationController

    def dummy
      logger.info "Hit dummy method"
      render :text => "Hit dummy method"
    end

    def provision
      logger.info "Overriding UnattendedController#provision in HubotNotify"
      uri = URI('http://ircbot:8080/hubot/irc')
      Net::HTTP.post_form(uri, 'message' => "Template requested: #{@host.name}")
      super
    end

  end
end
