class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to recipes_path
    end
  end
end
