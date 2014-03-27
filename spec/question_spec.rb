require 'spec_helper'

describe Question do
  it { should validate_presence_of :query }
  it { should validate_presence_of :survey_id }
  it { should belong_to :survey }
  it { should have_many :answers }
  it { should have_many :survey_takers }
end
