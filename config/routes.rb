Preparedly::Application.routes.draw do

  resources :contacts
  resources :completed_tasks
  resources :tasks do
    resources :comments
  end
  
  match "/tasks-partial" => "tasks#partial"

  match "resources" => "resources#index"
  match "/alert" => "resources#alert"

  match 'completed' => 'completed_tasks#completed' #, :as => 'completed'

  match 'remind/:task_id' => 'messages#remind', :as => 'reminder'

  #match "completed" => :controller => { :completed_tasks => "completed" }

  # match 'contact' => 'contact#new', :as => 'contact', :via => :get
  # match 'contact' => 'contact#create', :as => 'contact', :via => :post

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users, :controllers => { 
      :omniauth_callbacks => "users/omniauth_callbacks",
      :registrations => "users/registrations" 
  }
  match "/mapinfo" => "map#mapinfo"
  post "map" => "map#post"

  match "share" => "share#index"
  get "about" => "about#index"

  match "users/get" => "users#get"
  resources :users

  match "survey" => redirect("http://bit.ly/preparedlysurvey")

  get "terms" => "terms#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
