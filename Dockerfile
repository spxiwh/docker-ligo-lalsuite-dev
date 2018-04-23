FROM ligo/lalsuite-dev:stretch

LABEL name="TESTING" \
      maintainer="Ian Harry <ian.harry@ligo.org>" \
      date="20180103" \
      support="NONE"

# Setup dependencies for lalsuite/PyCBC. Lalsuite is mostly in place but missing openmpi, PyCBC needs a bunch of stuff.
RUN apt-get --assume-yes update \
&& apt-get --assume-yes upgrade \
&& apt-get --assume-yes install vim \
&& apt-get --assume-yes install curl \
&& apt-get --assume-yes install python-setuptools python-dev build-essential \
&& apt-get --assume-yes install openmpi-bin openmpi-doc libopenmpi-dev \
&& easy_install pip \
&& pip install --upgrade virtualenv \
&& pip install --upgrade pip \
&& pip install --upgrade setuptools \
&& pip install "numpy>=1.6.4" unittest2 python-cjson Cython decorator \
&& SWIG_FEATURES="-cpperraswarn -includeall -I/usr/include/openssl" pip install M2Crypto \
&& pip install http://download.pegasus.isi.edu/pegasus/4.7.3/pegasus-python-source-4.7.3.tar.gz \
&& pip install dqsegdb \
&& pip install ligo-gracedb \
&& pip install mpi4py \
&& pip install -I pyscaffold==2.5.8 \
&& pip install -I astropy==2.0.3 \
&& mkdir -p /TEMP/lscsoft && cd /TEMP/lscsoft && git clone https://git.ligo.org/lscsoft/lalsuite.git \
&& cd lalsuite && git checkout master  && ./00boot  \
&& ./configure --prefix=/usr --disable-lalstochastic --enable-mpi --enable-openmp && make install -j \
&& mkdir -p /TEMP/lalsuite_extra && cd /TEMP/lalsuite_extra \
&& curl http://software.ligo.org/lscsoft/source/lalsuite-extra-1.3.0.tar.gz > lalsuite-extra-1.3.0.tar.gz \
&& cd /TEMP/lalsuite_extra && tar -zxvf lalsuite-extra-1.3.0.tar.gz && cd lalsuite-extra-1.3.0/data/lalsimulation \
&& mkdir -p /usr/share/lalsimulation/ && cp * /usr/share/lalsimulation/ \
&& mkdir -p /ROQ_data/IMRPhenomPv2/32s && cd /ROQ_data/IMRPhenomPv2/32s && curl https://minerva.aei.mpg.de/~mpuer/ROQ/32s/bases_32s.tar > bases_32s.tar \
&& tar -xvf bases_32s.tar && rm -f bases_32s.tar \
&& mkdir -p /TEMP/pycbc && cd /TEMP/pycbc && git clone https://github.com/ligo-cbc/pycbc.git && cd pycbc && python setup.py install \
&& mkdir -p /TEMP/pylal && cd /TEMP/pylal && git clone https://git.ligo.org/lscsoft/pylal.git && cd pylal && python setup.py install \
&& rm -rf /var/lib/apt/lists/* /TEMP/
