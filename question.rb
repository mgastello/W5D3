require_relative 'all_classes'

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


    def self.find_by_author_id(author_id)
        question = QuestionsDB.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE
                user_id = ? 
        SQL
        question.map { |q| Question.new(q) }
    end


    def initialize(values)
        @id = values['id']
        @title = values['title']
        @body = values['body']
        @user_id = values['user_id']
    end
  
    def author
        result = QuestionsDB.instance.execute(<<-SQL, self.user_id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL

        User.new(result)
    end

    def replies
        
    end
end