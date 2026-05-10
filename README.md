# JumperCable

Hotwire and MVC is a powerful combination for building maintainable, accessible Rails applications.
But as your app grows, the presentation layer gets scattered across different controllers:
- login form in `sessions#new`
- signup in `registrations#new`
- profiles in `users#show`

Finding which controller renders which page becomes ambiguous.

JumperCable solves this by codifying a "page controller" pattern. 
Every page in your app gets a single canonical home, making your application's structure immediately navigable.

Think of your resource controllers as an **engine**... it handles the business logic and data.
Pages are the presentation layer, and turbo frames are the **jumper cables**... wires that connect your engine to presentation of your app.

## Installation

Add to your Gemfile:

```bash
bundle add jumper_cable
```

## Usage

### Routing DSL

```ruby
# config/routes.rb
Rails.application.routes.draw do
  page :login                    # GET /login -> pages/login_page#page
  page :profile, params: [:id]   # GET /profile/:id -> pages/profile_page#page

  namespace :about do
    page :team                   # GET /about/team -> pages/about/team_page#page
  end
end
```

### Generator

```bash
rails generate jumper_cable:page Login
# creates app/controllers/pages/login_page_controller.rb
# creates app/views/pages/login_page/page.html.erb

rails generate jumper_cable:page About::Team
# creates app/controllers/pages/about/team_page_controller.rb
# creates app/views/pages/about/team_page/page.html.erb
```

### Page Controllers

Page controllers inherit from `JumperCable::PageController` and define a single `page` action:

```ruby
class Pages::LoginPageController < JumperCable::PageController
  def page
    # optionally fetch data for the page
  end
end
```

### Page Views

Pages are shells for Turbo Frames. Resource controllers power the frames — pages just wire them together:

```erb
<%# app/views/pages/login_page/page.html.erb %>
<%= turbo_frame_tag "login-form" %>
<%= turbo_frame_tag "login-errors" %>
```

### Configure PageController Class

You can configure the base class by adding an initializer in your config directory.

```ruby
JumperCable.configure do |config|
  config.base_controller = "ApplicationController"
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/spencer-burke/jumper_cable.

## License

MIT
