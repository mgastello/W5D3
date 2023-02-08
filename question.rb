require_relative 'database'
require 'sqlite3'

class Question
    attr_accessor :id, :title, :body, :user_id
    
    def self.find_by_id(id)
        question = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        return nil unless question.length > 0

        Question.new(question)
    end

    def initialize(values)
        @id = values['id']
        @fname = values['fname']
        @lname = values['lname']
    end
  
end