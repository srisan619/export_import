class City < ActiveRecord::Base

  scope :active, where(:status=>true).select(:name)
  scope :published, where(:published => true)
end
