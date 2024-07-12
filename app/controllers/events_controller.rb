class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees
  end 

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def attend
    @event = Event.find(params[:id])
    attendance = @event.attendances.build(attendee: current_user)
    if attendance.save
      redirect_to @event, notice: "You have successfully RSVPed to the event."
    else
      Rails.logger.debug attendance.errors.full_messages.to_sentence
      redirect_to @event, alert: "There was a problem RSVPing to the event."
    end
  end

  def unattend
    @event = Event.find(params[:id])
    attendance = @event.attendances.find_by(attendee_id: current_user.id)
    attendance.destroy if attendance
    redirect_to @event, notice: "You have successfully unRSVPed from the event."
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :location)
  end

end
