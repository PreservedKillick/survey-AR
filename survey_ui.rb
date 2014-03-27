require 'active_record'
require 'pry'
require './lib/answer'
require './lib/question'
require './lib/survey'
require './lib/survey_taker'
require './lib/taker_response'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

system "clear"

def welcome
  puts "Welcome to the survey app, which you can use to build, take, and analyze surveys."
  welcome_choice = nil
  until welcome_choice == 'X'
    puts "\nAre you here as a"
    puts "\tsurvey designer?  press 'D'"
    puts "\tsurvey taker? press 'T'"
    puts "\nPress 'X' to exit the app\n\n"
    welcome_choice = gets.chomp.upcase
    case welcome_choice
    when 'D'
      designer_menu
    when 'T'
      taker_menu
    when 'X'
      puts "\nHave a nice day!\n\n"
    else
      puts "\nSorry, that wasn't a valid option."
    end
  end
end

def designer_menu
  system "clear"
  puts "Welcome, survey designer.  What would you like to do?"
  puts "\n\t'S' to create a new survey"
  puts "\t'E' to view all the surveys and to edit or delete surveys"
  puts "\t'Q' to create a new survey question"
  puts "\t'A' to create possible answers for each survey question"
  puts "\t'M' to return to the main menu"
  puts "\t'X' to exit the app"
  designer_choice = gets.chomp.upcase

  case designer_choice
  when 'S'
    create_survey
  when 'E'
    list_surveys
  when 'Q'
    create_question
  when 'A'
    create_answer
  when 'M'
    welcome
  when 'X'
    puts "\nHave a nice day!\n\n"
    exit
  else
    puts "\nSorry, that wasn't a valid option."
  end
end

def create_survey
  system "clear"
  puts "Enter the name of the survey you want to create:\n"
  title_input = gets.chomp
  new_survey = Survey.new({:title => title_input})
  if new_survey.save
    puts "\n\n'#{new_survey.title}' survey has been created."
  else
    puts "\nThat was not a valid survey title."
    new_survey.errors.full_messages.each { |message| puts message }
  end

  puts "Press 'C' to create another survey or 'D' to return to the designer menu."
  input = gets.chomp.upcase
  case input
  when 'C'
    create_survey
  when 'D'
    designer_menu
  else
    puts "\nSorry, that wasn't a valid input"
  end
end

def list_surveys
  system "clear"
  puts "Here are all of the surveys currently in your database:\n"
  puts_all_surveys

  puts "\nWould you like to edit or delete a survey? Y/N"
  input = gets.chomp.upcase
  case input
  when 'N'
    puts "\n\n"
    designer_menu
  when 'Y'
    puts "\n\n"
    puts "Press 'E' to edit or 'D' to delete a survey."
    ed_input = gets.chomp.upcase
    case ed_input
    when 'E'
      edit_survey
    when 'D'
      delete_survey
    else
      puts "\nSorry, that was not a valid input"
    end
  end
end

def edit_survey
  system "clear"
  puts_all_surveys
  puts "\n\nEnter the number of the survey you would like to edit"
  edit_number = gets.chomp.to_i - 1
  survey_to_edit = Survey.all[edit_number]
  puts "\nEnter the new title for the #{survey_to_edit.title} survey"
  new_title = gets.chomp
  survey_to_edit.update({:title => new_title})
  if survey_to_edit.save
    puts "\n'#{survey_to_edit.title}' survey has been updated"
  else
    puts "\nThat was not a valid survey title"
    survey_to_edit.errors.full_messages.each {|message| puts message}
  end

  puts "Press 'E' to edit another survey or 'D' to return to the designer menu."
  input = gets.chomp.upcase
  case input
  when 'E'
    edit_survey
  when 'D'
    designer_menu
  else
    puts "\nSorry, that wasn't a valid input"
  end
end

def delete_survey
  system "clear"
  puts_all_surveys
  puts "\n\nEnter the title of the survey you would like to delete"
  delete_input = gets.chomp.upcase
  Survey.where(:title => delete_input).first.destroy
  puts "\nThe #{delete_input} survey has been deleted from your database"

  puts "Press 'D' to delete another survey or 'M' to return to the designer menu."
  input = gets.chomp.upcase
  case input
  when 'D'
    delete_survey
  when 'M'
    designer_menu
  else
    puts "\nSorry, that wasn't a valid input"
  end
end

def create_question
  system "clear"
  puts "Enter the question you would like to add below:\n\n"
  query_input = gets.chomp.capitalize
  puts "\n\nEnter the number of the survey this question should belong to"
  puts_all_surveys
  index_input = gets.chomp.to_i - 1
  survey_to_add = Survey.all[index_input]
  new_question = Question.create({:query => query_input, :survey_id => survey_to_add.id})
  if new_question.save
    puts "\n\n'#{new_question.query}' has added to the survey #{survey_to_add.title}."
  else
    puts "\nThat was not a valid entry."
    new_question.errors.full_messages.each { |message| puts message }
  end

  puts "\n\nWould you like to create another question? Y/N"
  puts "\nOr, if you would like to create te possible answers for a question, enter 'A'"
  input = gets.chomp.upcase
  case input
  when 'Y'
    create_question
  when 'N'
    designer_menu
  when 'A'
    create_answer
  else
    puts "That was not a valid entry"
  end
end

def create_answer
  system "clear"
  letters = ('A'..'F').to_a
  add_another = 'Y'
  puts_all_questions
  q_selection = get_input("\nEnter the number of the question you would like to create possible answers for.\n")
### need to rejigger so that all answers for one question are being added in one go ###
  if /\D/.match(q_selection)
    puts "\nPlease enter a valid selection\n"
  else
    until add_another == 'N'
      q_to_be_answered = Question.all[q_selection.to_i - 1]
      new_response = get_input("Enter the response to '#{q_to_be_answered.query}'")
      selection = letters.shift
      new_answer = Answer.create({:selection => selection, :response => new_response, :question_id => q_to_be_answered.id})
      puts "#{new_answer.selection}. #{new_answer.response} for the question #{q_to_be_answered.query} has been added"
      if selection == 'F'
        puts "Please contact your system administrator to add another possible answer to this question"
        add_another = 'N'
      else
        add_another = get_input("Do you want to add another answer? Y/N").upcase
      end
    end
  end
end





##########################
## helper methods below ##
##########################

def puts_all_surveys
  Survey.all.each_with_index { |survey, index| puts "\t#{index+1}\t#{survey.title}"}
end

def puts_all_questions
  Question.all.each_with_index do |question, index|
    puts "#{index+1}.\t#{question.query}"
    puts "\tfrom survey #{question.survey.title}\n"
  end
end

def get_input(question)
  puts question
  gets.chomp
end


welcome
