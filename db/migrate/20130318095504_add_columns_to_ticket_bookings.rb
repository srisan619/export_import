class AddColumnsToTicketBookings < ActiveRecord::Migration
  def self.up
    add_column :ticket_bookings, :fare, :float
    add_column :ticket_bookings, :route, :string
    add_column :ticket_bookings, :status, :string ,:default => true
    add_column :ticket_bookings, :seat_no, :integer
  end

  def self.down
    remove_column :ticket_bookings, :fare
    remove_column :ticket_bookings, :route
    remove_column :ticket_bookings, :status
    remove_column :ticket_bookings, :seat_no
  end
end
