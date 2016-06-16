require 'akm_rails_generators'

module AkmRailsGenerators
  class Railtie < Rails::Railtie

    generators do |g|
      Rails::Generators.templates_path.unshift(File::expand_path('../../templates', __FILE__))
    end

  end
end
