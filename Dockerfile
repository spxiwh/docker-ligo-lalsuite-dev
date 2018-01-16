FROM ligo/lalsuite-dev:jessie

LABEL name="TESTING" \
      maintainer="Ian Harry <ian.harry@ligo.org>" \
      date="20180103" \
      support="NONE"

# Setup dependencies for lalsuite/PyCBC. Lalsuite is mostly in place but missing openmpi, PyCBC needs a bunch of stuff.
RUN apt-get --assume-yes update
RUN apt-get --assume-yes upgrade
RUN apt-get --assume-yes install vim
RUN apt-get --assume-yes install python-setuptools python-dev build-essential
RUN apt-get --assume-yes install openmpi-bin openmpi-doc libopenmpi-dev
RUN easy_install pip
RUN pip install --upgrade virtualenv
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install "numpy>=1.6.4" unittest2 python-cjson Cython decorator
RUN SWIG_FEATURES="-cpperraswarn -includeall -I/usr/include/openssl" pip install M2Crypto
RUN pip install http://download.pegasus.isi.edu/pegasus/4.7.3/pegasus-python-source-4.7.3.tar.gz
RUN pip install dqsegdb
RUN pip install ligo-gracedb
RUN pip install -I pyscaffold==2.5.8

# Complete lalsuite install, can add a specific lalsuite tag here
RUN mkdir -p /TEMP/lscsoft && cd /TEMP/lscsoft && git clone https://git.ligo.org/lscsoft/lalsuite.git && cd lalsuite && git checkout master  && ./00boot && ./configure --prefix=/usr --disable-lalstochastic --enable-mpi --enable-openmp && make install -j

# Also need lalsuite extra
RUN mkdir -p /TEMP/lscsoft_extra && cd /TEMP/lscsoft_extra && git clone https://git.ligo.org/lscsoft/lalsuite-extra.git && ./configure --prefix=/usr && make install

# Complete pycbc install, add a git checkout HASH command if not wanting to install origin/master
RUN mkdir -p /TEMP/pycbc && cd /TEMP/pycbc && git clone https://github.com/ligo-cbc/pycbc.git && cd pycbc && python setup.py install

# clear package cache and TEMP directories
RUN rm -rf /var/lib/apt/lists/* /TEMP/lscsoft /TEMP/pycbc
