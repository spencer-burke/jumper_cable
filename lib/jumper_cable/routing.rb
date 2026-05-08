module JumperCable
  module Routing
    def page(name, params: [], &block)
      controller = resolve_controller(name)
      path = resolve_path(name, params)

      get path, to: "#{controller}#page"
    end

    private

    def resolve_controller(name)
      "pages/#{name}_page"
    end

    def resolve_path(name, params)
      segments = [name.to_s] + params.map {|p| ":#{p}"}
      "/#{segments.join("/")}"
    end
  end
end
