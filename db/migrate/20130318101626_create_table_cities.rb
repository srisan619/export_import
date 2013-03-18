class CreateTableCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :name
      t.string :state
      t.string :status ,:default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
