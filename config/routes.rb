Erp::NsClouds::Engine.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
		namespace :backend, module: "backend", path: "backend/ns_clouds" do
      resources :plans do
        collection do
          post 'list'
          get 'dataselect'
          delete 'delete_all'
          put 'archive'
          put 'unarchive'
          put 'archive_all'
          put 'unarchive_all'
          get 'form_plan_detail'
        end
      end
      resources :accounts do
        collection do
          post 'list'
          get 'dataselect'
          delete 'delete_all'
          put 'archive'
          put 'unarchive'
          put 'archive_all'
          put 'unarchive_all'
        end
      end
      resources :subscriptions do
        collection do
          post 'list'
          get 'dataselect'
          delete 'delete_all'
          put 'archive'
          put 'unarchive'
          put 'archive_all'
          put 'unarchive_all'
        end
      end
    end
	end
end