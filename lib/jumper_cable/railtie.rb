module JumperCable
  class Railtie < Rails::Railtie
    initializer "jumper_cable.routing" do
      ActionDispatch::Routing::Mapper.include(JumperCable::Routing)
    end
  end
end
