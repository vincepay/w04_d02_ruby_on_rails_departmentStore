Rails.application.routes.draw do
  # get 'departments/index'
  # get 'departments/show'
  # get 'departments/new'
  # get 'departments/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "departments#index"
  resources :departments
end
