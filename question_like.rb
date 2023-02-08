require_relative 'database'
require 'sqlite3'

class Like
    attr_accessor :id, :user_id, :question_id
    
    def self.find_by_id(id)
        like = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_likes
            WHERE
                id = ?
        SQL
        return nil unless like.length > 0

        Like.new(like)
    end

    def initialize(values)
        @id = values['id']
        @user_id = values['user_id']
        @question_id = values['question_id']
    end
  
end