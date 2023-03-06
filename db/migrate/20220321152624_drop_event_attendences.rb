class DropEventAttendences < ActiveRecord::Migration[6.1]
  def change
    drop_table :event_attendences
  end
end
