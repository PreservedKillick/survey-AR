class Survey < ActiveRecord::Base
  has_many :questions
  has_many :answers, through: :questions
  before_save :upcase_title

  validates :title, :presence => true
  validates :title, :uniqueness => true

  private

    def upcase_title
      self.title = self.title.upcase
    end
end
