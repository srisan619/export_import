class Category < ActiveRecord::Base
    has_many :products
  validates :name, :category_type, :presence => true
  has_attached_file :photo, :styles => {:small => "150x150>"}
validates_attachment_size :photo, :less_than => 5.megabytes
validates_attachment_content_type :photo, :content_type => ['image/jpeg','image/png']
end
