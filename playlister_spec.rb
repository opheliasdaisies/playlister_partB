require "./spec_helper"
require "./lib/artist"
require "./lib/song"
require "./lib/genre"

describe "playlister" do
  it 'Can initialize an Artist' do
    lambda {Artist.new}.should_not raise_error
  end

  it 'An artist can have a name' do
    artist = Artist.new
    artist.name = "Adele"
    artist.name.should eq("Adele")
  end

  it "An artist has songs" do
    artist = Artist.new
    artist.songs = []
    artist.songs.should eq([])
  end

  it 'The Artist class can reset the artists that have been created' do
    lambda {Artist.reset_artists}.should_not raise_error
    Artist.count.should eq(0)
  end

  it 'The Artist class can keep track of artists as they are created' do
    Artist.reset_artists
    artist = Artist.new
    Artist.all.should include(artist)
  end

  it 'The Artist class can count how many artists have been created' do
    lambda {Artist.count}.should_not raise_error
  end

  it 'artists have songs' do
    artist = Artist.new
    songs = (1..4).collect{|i| Song.new}
    artist.songs = songs

    artist.songs.should eq(songs)
  end

  it 'An artist can count how many songs they have' do
    artist = Artist.new
    songs = [Song.new, Song.new]
    artist.songs = songs

    artist.songs_count.should eq(2)
  end

  it 'a song can be added to an artist' do
    artist = Artist.new
    song = Song.new
    artist.add_song(song)

    artist.songs.should include(song)
  end

  it 'artists have genres' do
    artist = Artist.new
    song = Song.new

    song.genre = Genre.new.tap{|g| g.name = "rap"}
    artist.add_song(song)

    artist.genres.should include(song.genre)
  end

  # Genre Specs
  it 'Can initialize a genre' do
    lambda {Genre.new}.should_not raise_error
  end

  it 'A genre has a name' do
    genre = Genre.new
    genre.name = 'rap'

    genre.name.should eq('rap')
  end

  it 'A genre has many songs' do
    genre = Genre.new.tap{|g| g.name = 'rap'}
    [1,2].each do
      song = Song.new
      song.genre = genre
    end

    genre.songs.count.should eq(2)
  end

  it 'A genre has many artists' do
    genre = Genre.new.tap{|g| g.name = 'rap'}

    [1,2].each do
      artist = Artist.new
      song = Song.new
      song.genre = genre
      artist.add_song(song)
    end

    genre.artists.count.should eq(2)
  end

  it 'A genres Artists are unique' do
    genre = Genre.new.tap{|g| g.name = 'rap'}
    artist = Artist.new

    [1,2].each do
      song = Song.new
      song.genre = genre
      artist.add_song(song)
    end

    genre.artists.count.should eq(1)
  end

  # Same behavior as Artists
  it 'The Genre class can keep track of all created genres' do
    Genre.reset_genres # You must implement a method like this
    genres = [1..5].collect do |i|
      Genre.new
    end

    Genre.all.should eq(genres)
  end

  # Extra Credit
  # Complete any song test that is pending (undefined).

  it 'Can initialize a song' do
    lambda {Song.new}.should_not raise_error
  end

  it 'A song can have a name' do
    song = Song.new
    song.name = "Sixteen Salteens"
    song.name.should eq("Sixteen Salteens")
  end

  it 'A song can have a genre' do
    song = Song.new
    new_genre = Genre.new
    song.genre = new_genre
    song.genre.should eq(new_genre)
  end

  it 'A song has an artist' do
    song = Song.new
    new_artist = Artist.new
    song.artist = new_artist
    song.artist.should eq(new_artist)
  end
end