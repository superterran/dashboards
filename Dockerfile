FROM ruby:latest
RUN apt-get update && apt-get install ruby-dev nodejs -y
RUN gem install bundler
RUN gem install smashing
RUN gem install execjs
CMD make run -C /app
EXPOSE 3030