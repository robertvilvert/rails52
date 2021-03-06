FROM ruby:2.5.1

WORKDIR /app

RUN gem install bundle && gem install rails

#keeps bundler updated
RUN gem update --system

# set env
ENV RAILS_VERSION 5.2.0
ENV LANG C.UTF-8

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY vendor/ vendor/

RUN bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment

COPY . .



CMD ["bundle", "exec", "rails", "s", "-e", "production", "-p", "80", "-b", "0.0.0.0" ]
