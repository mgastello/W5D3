require_relative 'all_classes'

class Reply
    attr_accessor :id, :question_id, :body, :parent_reply, :user_id
    
    def self.find_by_id(id)
        reply = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        return nil unless reply.length > 0

        Reply.new(reply)
    end


    def self.find_by_user_id(user_id)
        replies = QuestionsDB.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                replies
            WHERE
                user_id = ?
        SQL

        replies.map { |reply| Reply.new(reply) }
    end

    def self.find_by_question_id(question_id)
        replies = QuestionsDB.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL

        replies.map { |reply| Reply.new(reply) }
    end

    def initialize(values)
        @id = values['id']
        @question_id = values['question_id']
        @body = values['body']
        @parent_reply = values['parent_reply']
        @user_id = values['user_id']
    end
  
end