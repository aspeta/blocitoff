class Todo < ActiveRecord::Base
#  attr_accessible :todo_descripton, :completed
  validates :descripton, presence: true
  belongs_to :user
end
