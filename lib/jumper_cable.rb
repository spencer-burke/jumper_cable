# frozen_string_literal: true

require_relative "jumper_cable/version"
require_relative "jumper_cable/routing"
require_relative "jumper_cable/railtie" if defined?(Rails)
require_relative "jumper_cable/page_controller" if defined?(Rails)

module JumperCable
  class Error < StandardError; end
end
