require 'akm_rails_generators'

module AkmRailsGenerators
  class Railtie < Rails::Railtie

    generators do |g|
      templates_dir = File::expand_path('../../templates', __FILE__)
      Rails::Generators.templates_path.unshift(templates_dir)
      Rails::Generators::ScaffoldControllerGenerator.source_paths.unshift(templates_dir)
    end

  end
end
