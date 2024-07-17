FROM ruby:3.3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  sqlite3 \
  libsqlite3-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install a specific version of Bundler
RUN gem install bundler -v 2.4.20

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Run migrations
RUN #bin/rails db:migrate || true

# Precompile assets (uncomment if in production)
# RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose port 80
EXPOSE 80

# Start the application
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "80"]
