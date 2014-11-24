# Scrobble Visualizer (alfa)

## Develop
```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
foreman start # Rails server
```

## Heroku

```
heroku create your-scrobble-visualizer-name
git push heroku master
heroku run rake db:migrate
heroku restart
heroku open
```

## Uses
* myqsl in development
* postgressql in production (for Heroku)

## License
MIT
