Tr8nServer::Application.routes.draw do
  mount Tr8n::Engine => "/tr8n"
  mount WillFilter::Engine => "/will_filter"

  root :to => "home#index"

  [:admins, :users].each do |ctrl|
    get "/admin/#{ctrl}", to: "admin/#{ctrl}#index"
    match "/admin/#{ctrl}/:custom_action", :controller => "admin/#{ctrl}", action: :route_controller_action, via: [:get, :post, :put]
  end

  namespace :admin do
    root :to => "users#index"
  end

  get '/home', to: 'home#index'

  # This is a no-no, but we don't care about the demo app that much
  # match ':controller(/:action(/:id(.:format)))', via: [:get, :post, :put]
end
