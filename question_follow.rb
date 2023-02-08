require_relative 'database'
require 'sqlite3'

class QuestionFollow
    attr_accessor :id, :question_id, :user_id
    
    def self.find_by_id(id)
        follow = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
        SQL
        return nil unless follow.length > 0

        QuestionFollow.new(follow)
    end

    def initialize(values)
        @id = values['id']
        @question_id = values['question_id']
        @user_id = values['user_id']
    end
  
end