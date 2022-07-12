# README

[![Brakeman](https://github.com/ham0215/line_message_yamanotenki/actions/workflows/brakeman.yml/badge.svg)](https://github.com/ham0215/line_message_yamanotenki/actions/workflows/brakeman.yml)
[![Eager Load](https://github.com/ham0215/line_message_yamanotenki/actions/workflows/eager_load.yml/badge.svg)](https://github.com/ham0215/line_message_yamanotenki/actions/workflows/eager_load.yml)
[![RSpec](https://github.com/ham0215/line_message_yamanotenki/actions/workflows/rspec.yml/badge.svg)](https://github.com/ham0215/line_message_yamanotenki/actions/workflows/rspec.yml)
[![RuboCop](https://github.com/ham0215/line_message_yamanotenki/actions/workflows/rubocop.yml/badge.svg)](https://github.com/ham0215/line_message_yamanotenki/actions/workflows/rubocop.yml)

This is a Line Messaging API that tells you the weather on the mountain.

## Usage

<img src="https://github.com/ham0215/line_message_yamanotenki/blob/master/yamanotenki.jpg" width=400px>

## Add friend

<img src="https://github.com/ham0215/line_message_yamanotenki/blob/master/qr.png" width="200px">

## System dependencies

- gem
  - line-bot-api
- database
  - postgres
  
## dependency update

Use renovate to automate software project dependency updates.

https://www.mend.io/free-developer-tools/renovate/

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

- Database settings  
  Set database connection information in `config/database.yml`.

## CI

CI is running on Cloud Build.  
Executing rspec, brakeman, rails_best_practices.

## Deployment

This application is running on Heroku.  
Deploy when merged into the main branch.

## References

- Line Developers  
  https://developers.line.biz/ja/services/messaging-api/

- Qiita  
  https://qiita.com/ham0215/items/0cff5eb7d1398f70141d
