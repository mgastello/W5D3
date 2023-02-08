require 'singleton'
require 'sqlite3'

class QuestionsDB < SQLite3::Database
include Singleton

  def initialize
    super('questions.db')
    self.type_translate = true
    self.results_as_hash = true
  end
end

