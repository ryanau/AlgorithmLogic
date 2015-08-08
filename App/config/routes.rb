Rails.application.routes.draw do
  resources :stocks
  resources :industries

  get '/recommendations', to: 'stocks#recommendations'
end
