class Scrobble < ActiveRecord::Base
  belongs_to :artist
  belongs_to :track

  validates_presence_of :artist, :track, :scrobbled_at

  def create_scrobbles(scrobbles)
    scrobbles.map do |scrobble|
      artist = Artist.where(name: scrobble[:artist]).first_or_create
      track  = Track.where(name: scrobble[:track], artist: artist).first_or_create
      Scrobble.create!(
        artist: artist,
        track: track,
        scrobbled_at: scrobble[:scrobbled_at].to_time(:utc)
      )
    end
  end
end
