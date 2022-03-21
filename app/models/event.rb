class Event < ApplicationRecord
  belongs_to :creator, class_name: "User" 
  has_many :event_attendences, foreign_key: :attended_event_id
  has_many :attendees, through: :event_attendences, source: :attendee
end
