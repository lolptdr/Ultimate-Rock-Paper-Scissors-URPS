require 'pry-byebug'
require 'pg'
require 'time'

module Arena
	class DBI
		def initialize
			@db = PG.connect(host: 'localhost', dbname: 'urps')
			build_tables
		end

		def build_tables
			@db.exec(%q[
				CREATE TABLE IF NOT EXISTS users(
					id serial NOT NULL PRIMARY KEY,
					username varchar(30)
					password_digest varchar(30)
					created_at timestamp NOT NULL DEFAULT current_timestamp
				])

			@db.exec(%q[
				CREATE TABLE IF NOT EXISTS matches(
					id serial NOT NULL PRIMARY KEY,
					game integer,
					status varchar(30),
					opponent varchar(30),
					created_at timestamp NOT NULL DEFAULT current_timestamp
				)])

			@db.exec(%q[
				CREATE TABLE IF NOT EXISTS games(
					id serial NOT NULL PRIMARY KEY,
					status varchar(30),
					opponent varchar(30),
					p1move text,
					p2move text,
					result varchar(30),
					created_at timestamp NOT NULL DEFAULT current_timestamp
				)])
		end

		def self.dbi
		  @__db_instance ||= DBI.new
		end
	end
end