class City < ActiveRecord::Base

  scope :active, where(:status=>true).select(:name)
  
end
