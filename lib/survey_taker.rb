class SurveyTaker < ActiveRecord::Base
  has_many :taker_responses
  has_many :answers, through: :taker_responses
end
