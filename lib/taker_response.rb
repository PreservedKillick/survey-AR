class TakerResponse < ActiveRecord::Base
  belongs_to :answer
  belongs_to :survey_taker
end
