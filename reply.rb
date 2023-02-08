require_relative 'database'
require 'sqlite3'

class User
    attr_accessor :id, :fname, :lname
    
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

    def initialize(values)
        @id = values['id']
        @fname = values['fname']
        @lname = values['lname']
    end
  
end