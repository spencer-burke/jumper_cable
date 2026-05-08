# JumperCable

This project is not yet complete, but I have been working on/researching/ideating it for months now.

### Why Does This Exist?

Hotwire and MVC is an amazing combination for building applications that are maintainable, simple, and accessible.
There is one problem.
The presentation layer of your app is scattered across different controllers.
Since everything a resource, the login form can be sessions#new and the sign up form will be signups#show.
As you can see, the "resourcefulness" can make the app harder to navigate.
Simply because the different pages are scattered between different actions.
This means matching actions to pages is fairly ambiguous.
As a result Hotwire applications can be very challenging to navigate.
An easy to way to fix this is create a new "page" resource.
That way every page in the application has a specific place.
As a result, getting a sitemap of your application simply means looking at the "pages" in the routing file.
This is where JumperCable comes in.
It serves to codify this pattern into a convention by creating a gem.
That way it's much easier to understand what is happening in the application.
This is especially true given that Hotwire is excellent for placing turbo frames in different pages sent to the client.
__Resource controllers now function almost exclusively as an api for pages__ which are shells for turbo frames.
Most of the Rails conventions already support this one form or another.
They just need to be connected with JumperCables.

### Before and After

#### Routing Before
```ruby
get "/sign_up", to: "signups#show" # sign up page
get "/login", to: "sessions#new" # login page
get "/users/:id", to: "users#show" # profile page (maybe something else?)
```

#### Routing After
```ruby
get "/sign_up", to: "signups#page" # sign up page
get "/login", to: "login#page" # login page
get "/users/:id", to: "profile#page" # profile page
```
Even cleaner with the new dsl:
```ruby
page "/sign_up"
page "/login"
page "/profile", params: [:id]
```

### Technical

The plan is to make the page route map to the page inside of the controller.
Simply codifying the convention.

### Planned Features

- Add generator for new page controllers
- Expand the routing dsl to add pages just like resource
- If needed, make it compatible with inertia rails

### DSL Plans

```ruby
page :login # automatically maps to the PageController/JumperCablePageController::LoginController
page :login, params: [:id, :search] # handling router parameters, params should be id and search
page "/login" to: "loginController#page"
page "/login", controller: "login"
```
Those are examples for the routing dsl.

### Controller Example

The controller should look like this:
```ruby
class LoginController < PageController
 	layout :unauthenticated_layout
	
	def page
		# you can still fetch data for the page if you want
		@data_that_could_be_fetched = Example.find(params[:you_get_the_point])
	end
end
```
## Generator Example
```bash
rails generate page Login
```
This creates the LoginController that extends the page controller.
## Page View Example
```erb
<%= turbo_frame_tag "user-profile-card" %>
<%= turbo_frame_tag "recent-activity" %>
<%= turbo_frame_tag "notifications" %>
```
or
```erb
<%= turbo_frame_tag "user-profile-card" do %>
  <%= render @profile_data %>  <!-- prefilled on first load -->
<% end %>
```
The frames are all lazy loaded.
This keeps things the cleanest and the simplest for most work.
You could also potentially do something to prefetch data.

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jumper_cable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/jumper_cable/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the JumperCable project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/jumper_cable/blob/main/CODE_OF_CONDUCT.md).
