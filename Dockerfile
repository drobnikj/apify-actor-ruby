# Use an official Ruby runtime
FROM ruby:2.6.3

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install depedencies
RUN bundle install

CMD ["ruby", "main.rb"]
