require 'pg'
require 'pry-byebug'

module Sesh
  class Connection
    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'sesh')

      # @db.exec(%q[
      #     CREATE TABLE users(username TEXT, password_digest TEXT);
      #     ])
    end

    def persist_user(user)
      @db.exec_params(%q[
        INSERT INTO users (username, password_digest)
        VALUES ($1, $2);
      ], [user.username, user.password_digest])
    end

    def get_user_by_username(username)
      result = @db.exec(%Q[
        SELECT * FROM users WHERE username = '#{username}';
      ])

      user_data = result.first
      if user_data
        build_user(user_data)
      else
        nil
      end
    end

    def username_exists?(username)
      result = @db.exec(%Q[
        SELECT * FROM users WHERE username = '#{username}';
      ])

      #This handles the problem if more than 1 username exists
      if result.count > 1
        true
      else
        false
      end
    end

    def build_user(data)
      Sesh::User.new(data['username'], data['password_digest'])
    end
  end

  def self.dbi
    @__db_instance ||= Connection.new
  end
end
