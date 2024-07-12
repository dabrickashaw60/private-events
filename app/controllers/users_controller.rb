# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @created_events = @user.created_events
    @attended_events = @user.attended_events
    @past_events = @user.attended_events.where("date < ?", Time.now)
    @upcoming_events = @user.attended_events.where("date >= ?", Time.now)
  end
end
