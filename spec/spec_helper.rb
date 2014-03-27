require 'active_record'
require 'rspec'
require 'shoulda-matchers'
require 'pry'

require 'answer'
require 'question'
require 'survey'
require 'survey_taker'
require 'taker_response'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))['test'])

RSpec.configure do |config|
  config.after(:each) do
    Answer.all.each { |answer| answer.destroy }
    Question.all.each { |question| question.destroy }
    Survey.all.each { |survey| survey.destroy }
    SurveyTaker.all.each { |survey_taker| survey_taker.destroy }
    TakerResponse.all.each { |taker_response| taker_response.destroy }
  end
end
