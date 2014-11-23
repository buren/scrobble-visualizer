class Scrobble < ActiveRecord::Base
  belongs_to :artist
  belongs_to :track

  validates_presence_of :artist, :track, :scrobbled_at
end
