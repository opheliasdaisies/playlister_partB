require_relative "./lib/artist.rb"
require_relative "./lib/genre.rb"
require_relative "./lib/song.rb"
require "awesome_print"

#Pull file names from directory
songs_array = Dir.entries("data").select {|f| !File.directory? f}

#Parser methods
def song_list(array)
	songs = []
	array.each do |song|
		song_artist = get_artist(song)
		song_name = get_name(song)
		song_genre = get_genre(song)
		new_song = create_song(song_name)		
		songs << new_song
		new_genre = return_or_create_genre(song_genre)
		new_artist = return_or_create_artist(song_artist)
		new_song.genre = new_genre
		new_song.artist = new_artist
		new_artist.add_song(new_song)
	end
	songs
end


def get_artist(song)
	split_song = song.split(" - ")
	split_song[0]
end

def get_name(song)
	split_song = song.split(" - ")
	split_song[1].split(" [")[0]
end

def get_genre(song)
	split_song = song.split(" - ")
	split_song[1].split(" [")[1].chomp("].mp3")
end

def create_song(song)
	new_song = Song.new
	new_song.name = song
	new_song
end

def return_or_create_genre(genre_name)
	Genre.all.each do |genre|
		return genre if genre.name == genre_name
	end
	new_genre = Genre.new
	new_genre.name = genre_name
	new_genre
end

def return_or_create_artist(artist_name)
	Artist.all.each do |artist|
		return artist if artist.name == artist_name
	end
	new_artist = Artist.new
	new_artist.name = artist_name
	new_artist
end

#User Interface Methods
def how_to_browse
	puts "Browse by artist or genre?"
	artist_genre = gets.chomp.downcase
	stock_responses(artist_genre)
	if artist_genre == "artist"
		list_artists
		select_artist
	elsif artist_genre == "genre"
		list_genres
	else
		how_to_browse
	end
end

def list_artists
	puts "There are #{Artist.count} artists available. They are:"
	artist_list = []
	Artist.all.each do |artist|
		artist_list << "#{artist.name} -- #{artist.songs_count} Songs"
	end
	puts artist_list
end

def select_artist
	puts "Select Artist"
	artist_choice = gets.chomp.downcase
	stock_responses(artist_choice)
	Artist.all.each do |artist|
		if artist.name.downcase == artist_choice
			puts "#{artist.name} - #{artist.songs_count} Songs"
			artist.songs.each do |song|
				puts "#{artist.songs.index(song) + 1} -- #{song.name} -- #{song.genre.name}"
			end
		else
			select_artist
		end
	end
end

def list_genres
	genres = []
	Genre.all.each {|genre| genres << genre.name}
	puts genres
end

def stock_responses(response)
	if response == "exit"
		puts "Goodybe."
		exit
	elsif response == "help"
		help		
	elsif response == "list artists"
		list_artists
	elsif response == "list genres"
		list_genres
	elsif response == "select artist"
		select_artist
	else
		puts "I did not understand that."
	end
end

def help
	puts "'exit' exits program"
	puts "'help' brings up a list of options"
	puts "'list artists' lists all artists"
	puts "'list genres' lists all genres"
end

song_list = song_list(songs_array)
how_to_browse
