class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index]

  # GET /events or /events.json
  def index
    @events = Event.all.order("created_at DESC")
  end

  # GET /events/1 or /events/1.json
  def show
    @event = Event.find(params[:id])
  end

  # GET /events/new
  def new
    @event = current_user.events.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def attend 
    @event = Event.find(params[:id])
    attended_event = EventAttendence.new(attendee_id: current_user.id, attended_event_id: @event.id)
    if attended_event.save
      flash[:notice] = "Congrats! You are attending this event!"
      redirect_to @event
    else
      flash[:alert] = "You are already on the list!"
      redirect_to @event
    end
  end

  def unattend
    @event = Event.find(params[:id])
    attended_event = EventAttendence.find(attendee_id: current_user.id, event_id: @event.id)
    attended_event.destroy
    flash[:notice] = "You are no longer attending this event!"
    redirect_to @event
  end
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :detail, :location)
    end
end
