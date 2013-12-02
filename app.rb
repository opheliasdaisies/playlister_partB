require_relative "./lib/artist.rb"
require_relative "./lib/genre.rb"
require_relative "./lib/song.rb"
require_relative "./lib/parser.rb"
require_relative "./lib/playlister.rb"
require "awesome_print"

playlist = Playlister.new(Parser.new("data").song_list)
playlist.playlister