FROM ruby:2.7.1

RUN apt-get update && apt-get install -y --no-install-recommends \
  curl build-essential libpq-dev && \
  curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -y nodejs yarn

RUN gem install bundler rails

WORKDIR /app

COPY rails/ .
RUN gem install rails bundler
RUN bundle install
RUN yarn install

EXPOSE 3000
EXPOSE 3035

CMD bundle exec rails s -p 3000 -b 0.0.0.0