module JumperCable
  module Routing
    def page(name, params: [], &block)
      controller = resolve_controller(name)
      path = resolve_path(name, params)

      get path, to: "#{controller}#page"
    end

    def namespace(name, &block)
      scope "/#{name}" do
        with_namespace(name) { yield }
      end
    end

    private

    def with_namespace(name, &block)
      @_jc_namespace = name

      yield

      @_jc_namespace = nil
    end

    def resolve_controller(name)
      if @_jc_namespace
        return "pages/#{@_jc_namespace}/#{name}_page"
      end

      return "pages/#{name}_page"
    end

    def resolve_path(name, params)
      segments = [name.to_s] + params.map {|p| ":#{p}"}

      return("/#{segments.join("/")}")
    end
  end
end
