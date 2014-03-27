
class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :taker_responses
  has_many :survey_takers, through: :taker_responses
end
