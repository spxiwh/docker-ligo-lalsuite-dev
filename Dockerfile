FROM ligo/lalsuite-dev:jessie

LABEL name="TESTING" \
      maintainer="Ian Harry <ian.harry@ligo.org>" \
      date="20180103" \
      support="NONE"

# FIXME: this should use the lscsoft-lalsuite-dev meta-package but
# that is out of date on Debian and needs to be updated
RUN apt-get update && apt-get --assume-yes install vim

RUN mkdir -p /TEMP/lscsoft && cd /TEMP/lscsoft && git clone https://git.ligo.org/lscsoft/lalsuite.git && cd lalsuite && git checkout master  && ./00boot && ./configure && make install -j

# clear package cache
RUN rm -rf /var/lib/apt/lists/*
