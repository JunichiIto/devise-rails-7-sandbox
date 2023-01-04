Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get 'home/index'
  devise_for :users
  root "home#index"
end
