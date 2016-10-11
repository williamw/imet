Rails.application.routes.draw do
  root :to => "home#index"

  resources :connections

  get 'nearby' => 'nearby#fb_json'
  
  get 'welense' => 'connections#new'
  get 'welense/thanks' => 'thanks#index'
  get "welense/sxsw2011" => redirect("/welense")

  get 'acknowledgements' => 'thanks#acknowledgements'
end
