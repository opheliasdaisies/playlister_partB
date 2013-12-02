require_relative "./lib/artist.rb"
require_relative "./lib/genre.rb"
require_relative "./lib/song.rb"
require_relative "./lib/parser.rb"
require "awesome_print"

#User Interface Methods
def playlister(all_songs)
	puts "Browse by artist or genre?"
	artist_genre = gets.chomp.downcase
	responses(all_songs, artist_genre)
end

def list_artists(all_songs)
	puts "There are #{Artist.count} artists available. They are:"
	artist_list = []
	Artist.all.each do |artist|
		artist_list << "#{artist.name} -- #{artist.songs_count} Songs"
	end
	puts artist_list
	select_artist(all_songs)
end

def select_artist(all_songs)
	puts "Select Artist"
	artist_choice = gets.chomp.downcase
	responses(all_songs, artist_choice)
	artist_match(all_songs, response)
end

def artist_match(all_songs, artist_choice)
	Artist.all.each do |artist|
		if artist.name.downcase == artist_choice
			puts "#{artist.name} - #{artist.songs_count} Songs"
			artist.songs.each do |song|
				puts "#{artist.songs.index(song) + 1}. #{song.name} -- #{song.genre.name.capitalize}"
			end
			return true
		end
	end
	false
end

def list_genres(all_songs)
	genres_sorted = Genre.all.sort_by do |genre| 
		genre.songs.length
	end
	genres_sorted.reverse.each do |genre|
		puts "#{genre.name.capitalize}: #{genre.songs.length} Songs, #{genre.artists.length} Artists"
	end
end

def select_genre(all_songs)
	puts "Select Genre"
	genre_choice = gets.chomp.downcase
	responses(all_songs, genre_choice)
	genre_match(all_songs, genre_choice)
end

def genre_match(all_songs, genre_choice)
	Genre.all.each do |genre|
		if genre_choice == genre.name.downcase
			puts "The #{genre.name.capitalize} genre has #{genre.songs.length} Songs and #{genre.artists.length} Artists:"
			genre.songs.each do |song|
				puts "#{genre.songs.index(song)+1}. #{song.name} -- #{song.artist.name}"
			end
			return true
		end
	end
	false
end

def song_match(all_songs, song_choice)
	all_songs.each do |song|
		if song.name.downcase == song_choice
			puts "#{song.name}"
			puts "Artist: #{song.artist.name}"
			puts "Genre: #{song.genre.name.capitalize}"
			return true
		end
	end
	false
end

def responses(all_songs, response)
	if response == "exit"
		puts "Goodybe."
		exit
	elsif response == "help"
		help(all_songs)		
	elsif response == "list artists" || response == "artist"
		list_artists(all_songs)
	elsif response == "list genres" || response == "genre"
		list_genres(all_songs)
	elsif response == "select artist"
		select_artist(all_songs)
	elsif response == "select genre"
		select_genre(all_songs)
	elsif artist_match(all_songs, response)
	elsif genre_match(all_songs, response)
	elsif song_match(all_songs, response)
	else
		puts "Sorry, I did not understand that. Type 'help' for a list of commands."
	end
	puts "Make a selection."
	new_response = gets.chomp
	responses(all_songs, new_response)
end

def help(all_songs)
	puts "'exit' exits program"
	puts "'help' brings up a list of options"
	puts "'list artists' lists all artists"
	puts "'list genres' lists all genres"
	puts "'select artist' allows you to select an artist"
	puts "'select genre' allows you to select a genre"
	puts "Typing the name of an artist, genre, or song will take you to the page for that item."
	response = gets.chomp.downcase
	responses(all_songs, response)
end

songs_array = Parser.new("data")
all_songs = songs_array.song_list
playlister(all_songs)
