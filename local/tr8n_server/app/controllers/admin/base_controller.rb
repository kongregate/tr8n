class Admin::BaseController < ApplicationController
  before_action :verify_admin_user
  ssl_allowed :route_controller_action if respond_to?(:ssl_allowed)

  layout 'admin'

  def route_controller_action
    self.action_name = params[:custom_action]
    public_send(params[:custom_action])
  end

private

  def verify_admin_user
    redirect_to("/home") unless current_user.admin?
  end

end
