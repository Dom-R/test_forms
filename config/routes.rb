Rails.application.routes.draw do

  # Normal routing
  # resources :categories do
  #   resources :sub_categories
  # end

  get '/admin', to: 'admin_panel#index'

  scope '/admin' do
    resources :sub_categories, only: [:edit] do
      resources :fields, only: [:create, :edit, :destroy]
    end
  end

  # Requested routing as defined on the README.rdoc.
  # NOTE: I didn't know if I should keep them in english or portuguese, so I keep them "following" how :id normally works
  match ':category_slug/:slug',  :as => :category_sub_category,
                        :via => :get,
                        :controller => :sub_categories,
                        :action => :show
end
