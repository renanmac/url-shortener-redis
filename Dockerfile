FROM ruby:2.7.4-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install build-essential -y

RUN mkdir /app
COPY Gemfile* app/

WORKDIR /app

RUN gem install bundler

RUN bundle
COPY . /app

CMD ["ruby" "server.rb"]