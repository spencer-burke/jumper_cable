module JumperCable
  module Generators
    class PageGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      def create_controller
        template "controller.rb.tt", "app/controllers/pages/#{file_name}_page_controller.rb"
      end

      def create_view
        template "view.html.erb.tt", "app/views/pages/#{file_name}_page/page.html.erb"
      end
    end
  end
end
