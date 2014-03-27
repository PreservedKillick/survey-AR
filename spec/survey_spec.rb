require 'spec_helper'

describe Survey do
  it { should validate_presence_of :title }
  it 'converts the title of the survey to uppercase' do
    new_survey = Survey.create({:title => "Best Book"})
    new_survey.title.should eq "BEST BOOK"
  end
  it { should have_many :questions}
  it { should have_many :answers}
  it { should validate_uniqueness_of :title}
end
