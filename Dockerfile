# Use an official Ruby runtime
FROM ruby:2.1-onbuild

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

CMD ["ruby", "main.rb"]