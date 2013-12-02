class Playlister
	attr_reader :all_songs

	def initialize(songs)	
		@all_songs = songs
	end

	def playlister
		puts "Browse by artist or genre?"
		artist_genre = gets.chomp.downcase
		responses(artist_genre)
	end

	def list_artists
		puts "There are #{Artist.count} artists available. They are:"
		artist_list = []
		Artist.all.each do |artist|
			artist_list << "#{artist.name} -- #{artist.songs_count} Songs"
		end
		puts artist_list
		select_artist
	end

	def select_artist
		puts "Select Artist"
		artist_choice = gets.chomp.downcase
		responses(artist_choice)
		artist_match(response)
	end

	def artist_match(artist_choice)
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

	def list_genres
		genres_sorted = Genre.all.sort_by do |genre| 
			genre.songs.length
		end
		genres_sorted.reverse.each do |genre|
			puts "#{genre.name.capitalize}: #{genre.songs.length} Songs, #{genre.artists.length} Artists"
		end
	end

	def select_genre
		puts "Select Genre"
		genre_choice = gets.chomp.downcase
		responses(genre_choice)
		genre_match(genre_choice)
	end

	def genre_match(genre_choice)
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

	def song_match(song_choice)
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

	def responses(response)
		if response == "exit"
			puts "Goodybe."
			exit
		elsif response == "help"
			help		
		elsif response == "list artists" || response == "artist"
			list_artists
		elsif response == "list genres" || response == "genre"
			list_genres
		elsif response == "select artist"
			select_artist
		elsif response == "select genre"
			select_genre
		elsif artist_match(response)
		elsif genre_match(response)
		elsif song_match(response)
		else
			puts "Sorry, I did not understand that. Type 'help' for a list of commands."
		end
		puts "Make a selection."
		new_response = gets.chomp
		responses(new_response)
	end

	def help
		puts "'exit' exits program"
		puts "'help' brings up a list of options"
		puts "'list artists' lists all artists"
		puts "'list genres' lists all genres"
		puts "'select artist' allows you to select an artist"
		puts "'select genre' allows you to select a genre"
		puts "Typing the name of an artist, genre, or song will take you to the page for that item."
		response = gets.chomp.downcase
		responses(response)
	end

end



