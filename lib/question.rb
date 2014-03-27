
class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :answers
  has_many :survey_takers, through: :answers

  validates :query, :presence => true
  validates :survey_id, :presence => true
end
