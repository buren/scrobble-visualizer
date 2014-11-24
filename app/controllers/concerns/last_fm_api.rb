class LastFmApi
  API_KEY    = ENV['LAST_FM_API_KEY']
  API_SECRET = ENV['LAST_FM_API_SECRET']

  def initialize
    lastfm         = Lastfm.new(API_KEY, API_SECRET)
    token          = lastfm.auth.get_token
    lastfm.session = lastfm.auth.get_session(token: token)['key']
    @lastfm        = lastfm
  end

  def scrobbles(user, options = {})
    opts      = { max_pages: 1 }.merge(options)
    last_page = nil
    (1..opts[:max_pages]).flat_map do |index|
      sleep 0.2
      scrobbles = @lastfm.user
        .get_recent_tracks(
          user: user,
          page: index,
          limit: 200
        )
      break if last_page == scrobbles
      last_page = scrobbles
      scrobble_info(scrobbles)
    end
  end

  private

  def scrobble_info(scrobbles)
    scrobbles.map do |scrobble|
      {
        artist:       scrobble['artist']['content'],
        track:        scrobble['name'],
        scrobbled_at: scrobble['date']['content']
      }
    end
  end
end