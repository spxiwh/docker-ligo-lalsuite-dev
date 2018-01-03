FROM spxiwh/docker-ligo-lalsuite-dev:jessie

LABEL name="TESTING" \
      maintainer="Ian Harry <ian.harry@ligo.org>" \
      date="20180103" \
      support="NONE"

RUN mkdir -p /TEMP/pycbc && cd /TEMP/pycbc && git clone https://github.com/ligo-cbc/pycbc.git && cd pycbc && python setup.py install

# clear package cache
RUN rm -rf /var/lib/apt/lists/*
