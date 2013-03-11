class AddColumnInCategoriesTable < ActiveRecord::Migration
  def self.up
    add_column :categories, :category_number, :integer
  end

  def self.down
    remove_column :categories, :category_number
  end
end
