module JumperCable
  class Configuration
    attr_accessor :base_controller

    def initialize()
      @base_controller = "ActionController::Base"
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
