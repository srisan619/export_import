class City < ActiveRecord::Base
  validates :name, :state, :presence => true
  validates :state, :length => { :minimum => 2 }
  validates :name, :length => { :maximum => 25 }
  validates :name, :state, :format => { :with => /\A[a-zA-Z]+\z/,
    :message => "Only letters allowed" }
  scope :active, where(:status=>true).select(:name)
  
end
