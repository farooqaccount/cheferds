class Review < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe
  
  validates :comment, presence: true, length: { minimum: 5, maximum: 1000 }
  
  #validates_uniqueness_of :chef, scope: :recipe
  
end