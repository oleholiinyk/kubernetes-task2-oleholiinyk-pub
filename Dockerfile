FROM ruby:3.3.1

RUN apt-get update -qq && \
    apt-get install -y postgresql-client \
    libpq-dev \
    postgresql \
    postgresql-contrib && \
    apt-get clean

WORKDIR /app
ENV RAILS_ENV=development

USER postgres

RUN /etc/init.d/postgresql start \
    && psql --command "CREATE USER pguser WITH SUPERUSER PASSWORD 'password';" \
    && createdb webapp_db

USER root

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 80