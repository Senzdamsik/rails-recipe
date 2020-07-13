class PagesController < ApplicationController
  
  def home
    redirect_to recipes_path if logged_in?  # "logged_in?" ini ada di application_controller.rb 
  end
end