class EventAttendenceController < ApplicationController
  private
  def event_attendence_params
    params.require(:event_attendence).permit(:event_id)
  end
end
