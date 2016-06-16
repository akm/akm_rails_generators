require 'akm_rails_generators'

module AkmRailsGenerators
  class Railtie < Rails::Railtie

    config.generators do |g|
      g.templates.unshift File::expand_path('../../templates', __FILE__)
    end
  
  end
end
