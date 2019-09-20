# README

This is a Line Messaging API that tells you the weather on the mountain.

## Ruby version
2.6.3

## Rails version
6.0.0

## System dependencies
* gem
  * line-bot-api
* database
  * postgres:11.3

## How to run the development  
The development environment runs on docker.  
```
# docker build and start in background
docker-compose up --build -d

# create database and migrate
docker-compose run web bundle exec rake db:create
docker-compose run web bundle exec rake db:migrate

# start in background
docker-compose up -d
```

## Configuration
* Database settings  
Set database connection information in `config/database.yml`.

## CI
CI is running on Cloud Build.  
Executing rspec, brakeman, rails_best_practices.

## Deployment
This application is running on Heroku.  
To deploy, login to the Heroku and execute manual deploy.

## References  
* Line Developers  
https://developers.line.biz/ja/services/messaging-api/

* Qiita  
https://qiita.com/ham0215/items/0cff5eb7d1398f70141d