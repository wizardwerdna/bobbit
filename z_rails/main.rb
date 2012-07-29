require_relative '../application'
require_relative 'initialize_and_seed_memory_repo'
require ::File.expand_path('../config/environment',  __FILE__)

module Bobbit

  class Main

    def call env
      ZRails::Application.call env
    end

  end

end
