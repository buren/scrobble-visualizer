require 'open-uri'
require 'nokogiri'

class ScrobbleService
  # Time to sleep between requests
  SLEEPTIME = 0.3

  def initialize(user, options = {})
    @user      = user
    @options   = options
  end

  # Download all scrobbles for user
  def scrobbles
    tracks_url_for(@user) { |url| tracks_for_url(url) }.flatten
  end

  private

  # Extract all scrobbles from service
  def tracks_for_url(url)
    sleep SLEEPTIME
    Nokogiri::HTML(open(url))
      .css(@options['base_selector'])
      .map { |s| scrobble_info(s) }
  end

  # Takes a Nokogiri::XML::Element and extracts artist and track info
  def scrobble_info(scrobble)
    artist       = scrobble.at_css(@options['artist_selector'])
    track        = scrobble.at_css(@options['track_selector'])
    scrobbled_at = scrobble.at_css(@options['scrobbled_at_selector'])
    {
      artist:       artist.content.strip,
      track:        track.content.strip,
      scrobbled_at: scrobbled_at.content.strip
    }
  end

  # Yield each constructed user url
  def tracks_url_for(user)
    tracks_url = @options['url']
    (1..@options['max_pages'].to_i).to_a
      .map! { |index| yield(format(tracks_url, user, index)) }
  end
end