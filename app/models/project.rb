class Project < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name

  validates :name, :presence => true

  has_many :tickets, :dependent => :delete_all
end
