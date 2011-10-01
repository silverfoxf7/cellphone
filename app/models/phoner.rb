class Phoner < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :when, :phone, :minutes, :destination
  validates_uniqueness_of :when, :scope => [:phone, :destination, :minutes]
  
end
