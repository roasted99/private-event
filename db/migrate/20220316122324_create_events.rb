class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :detail
      t.datetime :starts_at
      t.string :location

      t.timestamps
    end
  end
end
