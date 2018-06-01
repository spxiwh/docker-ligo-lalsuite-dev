FROM debian:jessie

LABEL name="TESTING" \
      maintainer="Ian Harry <ian.harry@ligo.org>" \
      date="20180103" \
      support="NONE"

# ensure non-interactive debian installation
ENV DEBIAN_FRONTEND noninteractive

# We just copy ligo/base and ligo/lalsuite-dev into here for partability
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
&& apt-get update && apt-get --assume-yes install apt-transport-https
&& echo "deb http://research.cs.wisc.edu/htcondor/debian/stable jessie contrib" > /etc/apt/sources.list.d/condor.list
&& echo "deb http://software.ligo.org/gridtools/debian jessie main" > /etc/apt/sources.list.d/gridtools.list
&& echo "deb http://software.ligo.org/lscsoft/debian jessie contrib" > /etc/apt/sources.list.d/lscsoft.list
&& echo "deb https://packagecloud.io/github/git-lfs/debian jessie main" > /etc/apt/sources.list.d/git-lfs.list
&& apt-key adv --keyserver pgp.mit.edu --recv-key 8325FECB83821E31D3582A69CE050D236DB6FA3F
&& apt-key adv --keyserver pgp.mit.edu --recv-key 4B9D355DF3674E0E272D2E0A973FC7D2670079F6
&& apt-key adv --keyserver pgp.mit.edu --recv-key 418A7F2FB0E1E6E7EABF6FE8C2E73424D59097AB
&& apt-get update && apt-get --assume-yes install apt-utils bash-completion && rm -rf /var/lib/apt/lists/*
&& apt-get update && apt-get --assume-yes install autoconf \
      automake \
      bc \
      build-essential \
      ccache \
      condor \
      doxygen \
      git \
      git-lfs \
      help2man \
      ldas-tools-framecpp-c-dev \
      libcfitsio-dev \
      libchealpix-dev \
      libfftw3-dev \
      libframe-dev \
      libglib2.0-dev \
      libgsl0-dev \
      libhdf5-dev \
      libmetaio-dev \
      liboctave-dev \
      libopenmpi-dev \
      libtool \
      libxml2-dev \
      pkg-config \
      python-dev \
      python-glue \
      python-h5py \
      python-healpy \
      python-numpy \
      python-reproject \
      python-scipy \
      python-shapely \
      python-six \
      swig3.0 \
      texlive
&& git lfs install
&& apt-get --assume-yes update \
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
