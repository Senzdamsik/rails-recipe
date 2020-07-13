class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_chef, :logged_in?

  def current_chef

    # Ini fungsinya agar tidak nge-hit database sering2
    # Maksudnya, kalau "@current_chef" belum ada, dia ngambil dari database. Kalau sudah ada, pakai yg sudah ada ini.

    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id] 
  end
    
  def logged_in?

    # Maksudnya adalah, kalau @current_chef ada nilainya, True. Kalau tidak ada, false.

    !!current_chef
  end
    
  def require_user
    if !logged_in?  # Maksudnya kalau belum login, maka ...
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end

end
