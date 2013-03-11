class ChangeColumnInCategoriesTable < ActiveRecord::Migration
  def self.up
    rename_column :categories , :type , :category_type
  end

  def self.down
    rename_column :categories , :category_type , :type
  end
end
