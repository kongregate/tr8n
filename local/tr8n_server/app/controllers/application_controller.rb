# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  ssl_allowed :route_controller_action if respond_to?(:ssl_allowed)
  helper :all # include all helpers, all the time

  rescue_from StandardError do |e|
    pp e.backtrace
    raise e
  end

  def route_controller_action
    self.action_name = params[:custom_action]
    public_send(params[:custom_action])
  end

  def current_user
    @current_user ||= (User.find_by_id(session[:user_id]) unless session[:user_id].blank?) || User.new
  end
  helper_method :current_user

  def login!(user)
    session[:user_id] = user.id
  end

  def logout!
    session[:user_id] = nil
  end

  def redirect_to_source
    return redirect_to(params[:source_url]) unless params[:source_url].blank?
    return redirect_to(request.env['HTTP_REFERER']) unless request.env['HTTP_REFERER'].blank?
    redirect_to_site_default_url
  end

end
