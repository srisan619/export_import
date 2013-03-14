class Category < ActiveRecord::Base
  has_many :products
  validates :name, :category_type,:category_number,:email, :presence => true
  validates :category_number , :numericality => {:only_integer=>true}
  validates :email, :format => { :with =>/^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i , :message => "Enter the valid email"}
  has_attached_file :photo, :styles => {:small => "150x150>"}
validates_attachment_size :photo, :less_than => 5.megabytes
validates_attachment_content_type :photo, :content_type => ['image/jpeg','image/png']
end
