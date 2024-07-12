class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: [:destroy]
  def index
    @past_events = Event.past
    @upcoming_events = Event.upcoming
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

  def destroy
    if @event && current_user == @event.creator
      @event.destroy
      redirect_to events_url, notice: 'Event was successfully deleted.'
    else
      redirect_to event_path(@event), alert: 'You are not authorized to delete this event.'
    end
  end

  private

  def set_event
    @event = Event.find_by(id: params[:id])
    unless @event
      redirect_to events_url, alert: 'Event not found.'
    end
  end

  def event_params
    params.require(:event).permit(:name, :date, :location)
  end

end
