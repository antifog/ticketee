class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :state

  attr_accessible :description, :title, :state_id

  validates :title, :presence => true
  validates :description, :presence => true, :length => { :minimum => 10 }

end
