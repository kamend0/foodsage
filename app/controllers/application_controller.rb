class ApplicationController < ActionController::Base
    protected
  
    def after_sign_in_path_for(resource)
      # Customize the path based on your requirements
      if resource.is_a?(User)
        recipes_path
      else
        super  # Default path
      end
    end
  end