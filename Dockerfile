FROM debian:stretch

LABEL name="TESTING" \
      maintainer="Ian Harry <ian.harry@ligo.org>" \
      date="20180103" \
      support="NONE"

# ensure non-interactive debian installation
ENV DEBIAN_FRONTEND noninteractive

# We just copy ligo/base and ligo/lalsuite-dev into here for partability
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
&& apt-get update \
&& apt-get install --assume-yes apt-transport-https apt-utils gnupg \
&& rm -rf /var/lib/apt/lists/* \
&& echo "deb http://software.ligo.org/gridtools/debian stretch main" > /etc/apt/sources.list.d/gridtools.list \
&& echo "deb http://software.ligo.org/lscsoft/debian stretch contrib" > /etc/apt/sources.list.d/lscsoft.list \
&& echo "deb https://packagecloud.io/github/git-lfs/debian stretch main" > /etc/apt/sources.list.d/git-lfs.list
# These seem to need to be separate commands. Not sure why!
