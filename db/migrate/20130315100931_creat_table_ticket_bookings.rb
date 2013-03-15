class CreatTableTicketBookings < ActiveRecord::Migration
   def self.up
    create_table :ticket_bookings do |t|
      t.string :from
      t.string :to
      t.datetime :onward

      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_bookings
  end
end
