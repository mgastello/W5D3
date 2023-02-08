require_relative 'database'
require 'sqlite3'

class User
    attr_accessor :id, :fname, :lname

    def self.find_all
        data = QuestionsDB.instance.execute("SELECT * FROM users")
        data.map { |datum| User.new(datum) }
    end

    def self.find_by_id(id)
        user = QuestionsDB.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL
        return nil unless user.length > 0

        User.new(user)
    end

    def self.find_by_name(fname, lname)
        user = QuestionsDB.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ?  AND
                lname = ?
        SQL
        return nil unless user.length > 0

        User.new(user)
    end
    
    def self.authored_questions(fname, lname)
        questions = QuestionsDB.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            JOIN questions
            ON users.id = questions.user_id
            WHERE
                fname = ? AND
                lname = ?

        SQL
        questions.map { |question| Question.new(question) }
    end

    def initialize(values)
        @id = values['id']
        @fname = values['fname']
        @lname = values['lname']
    end

  
end