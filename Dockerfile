FROM ruby:3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client


WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

COPY . .

# Precompile assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Application port
EXPOSE 80

CMD ["rails", "s", "-b", "0.0.0.0", "-p", "80"]