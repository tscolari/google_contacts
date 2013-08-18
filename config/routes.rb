GoogleAgenda::Application.routes.draw do
  get "contacts/index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  authenticate :user do
    resources :contacts, only: [:index]
  end

end
