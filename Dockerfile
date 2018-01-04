FROM spxiwh/docker-ligo-lalsuite-dev:jessie

LABEL name="TESTING" \
      maintainer="Ian Harry <ian.harry@ligo.org>" \
      date="20180103" \
      support="NONE"

RUN apt-get --assume-yes update
RUN apt-get --assume-yes upgrade
RUN apt-get --assume-yes install python-setuptools python-dev build-essential
RUN easy_install pip
RUN pip install --upgrade virtualenv
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install "numpy>=1.6.4" unittest2 python-cjson Cython decorator
RUN SWIG_FEATURES="-cpperraswarn -includeall -I/usr/include/openssl" pip install M2Crypto
RUN pip install http://download.pegasus.isi.edu/pegasus/4.7.3/pegasus-python-source-4.7.3.tar.gz
RUN pip install dqsegdb
RUN pip install ligo-gracedb
RUN mkdir -p /TEMP/pycbc && cd /TEMP/pycbc && git clone https://github.com/ligo-cbc/pycbc.git && cd pycbc && python setup.py install

# clear package cache
RUN rm -rf /var/lib/apt/lists/*
