FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y postgresql-client vim locales locales-all

ENV LANG ja_JP.UTF-8

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem update bundler
RUN bundle install
COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]
