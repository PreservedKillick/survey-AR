require 'spec_helper'

describe Answer do
  it { should belong_to :question}
  it { should have_many :survey_takers }
  it { should have_many :taker_responses }
end
