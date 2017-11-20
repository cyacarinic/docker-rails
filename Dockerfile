FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /myapp
WORKDIR /myapp

ADD ./code/Gemfile /myapp/Gemfile
ADD ./code/Gemfile.lock /myapp/Gemfile.lock

RUN bundle install

ADD ./code /myapp
