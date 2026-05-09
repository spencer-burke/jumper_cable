Rails.application.routes.draw do
  page :login

  namespace :about do
    page :team
  end
end
