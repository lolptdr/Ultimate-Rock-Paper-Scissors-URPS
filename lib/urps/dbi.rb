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
					user_id integer REFERENCES users(id),
					game serial NOT NULL,
					status varchar(30),
					opponent varchar(30),
					created_at timestamp NOT NULL DEFAULT current_timestamp
				)])

			@db.exec(%q[
				CREATE TABLE IF NOT EXISTS games(
					id serial NOT NULL PRIMARY KEY,
					matches_id integer REFERENCES matches(id),
					status varchar(30),
					opponent varchar(30),
					p1move text,
					p2move text,
					result varchar(30),
					created_at timestamp NOT NULL DEFAULT current_timestamp
				)])

			@db.exec(%q[
				CREATE TABLE IF NOT EXISTS records(
					id serial NOT NULL PRIMARY KEY,
					user_id integer REFERENCES users(id),
					total_matches integer,
					match_wins integer,
					match_losses integer,
					game_wins integer,
					game_losses integer,
					game_ties integer,
					favorite_move text,
					highest_winning_move_vs_opponent text,
					highest_losing_move_vs_opponent text,
					%rock double precision,
					%paper double precision,
					%scissors double precision,
					created_at timestamp NOT NULL DEFAULT current_timestamp
				)])
		end


		def self.dbi
		  @__db_instance ||= DBI.new
		end
	end
end