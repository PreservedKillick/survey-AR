require 'spec_helper'

describe TakerResponse do
  it { should belong_to :answer }
  it { should belong_to :survey_taker }
end
