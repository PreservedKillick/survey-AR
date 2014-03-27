require 'spec_helper'

describe SurveyTaker do
  it { should have_many :taker_responses }
  it { should have_many :answers }
end
