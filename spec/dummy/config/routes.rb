Rails.application.routes.draw do
  page :login
  page :dashboard

  page :profile, params: [:id]

  namespace :about do
    page :team
  end
end
