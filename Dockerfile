FROM ruby:latest
COPY * /app
RUN cd /app
RUN bundle
CMD smashing start
EXPOSE 3030