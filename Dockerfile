FROM ruby:3.3.1

RUN apt-get update -qq && apt-get install -y \
  sqlite3 \
  libsqlite3-dev \
  && apt-get clean

WORKDIR /app
ENV RAILS_ENV=production

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "80"]