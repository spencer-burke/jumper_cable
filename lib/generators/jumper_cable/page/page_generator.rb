module JumperCable
  module Generators
    class PageGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      def create_controller
        template "controller.rb.tt", "app/controllers/pages/#{namespaced_path}_page_controller.rb"
      end

      def create_view
        template "view.html.erb.tt", "app/views/pages/#{namespaced_path}_page/page.html.erb"
      end

      private

      def namespaced_path
        (class_path + [file_name]).join("/")
      end
    end
  end
end
