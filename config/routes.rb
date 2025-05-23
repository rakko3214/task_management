Rails.application.routes.draw do
  resources :tasks do
    member do
      patch :toggle_done
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  root "tasks#index"
end
