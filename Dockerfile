FROM ligo/lalsuite-dev:stretch

LABEL name="TESTING" \
      maintainer="NONE" \
      date="20180101" \
      support="NONE"

RUN apt-get update && apt-get --assume-yes install vim

# clear package cache
RUN rm -rf /var/lib/apt/lists/*
