FROM ligo/ligo-base:stretch

LABEL name="LALSuite Development Debian Stretch" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20170529" \
      support="Best Effort"

# FIXME: this should use the lscsoft-lalsuite-dev meta-package but
# that is out of date on Debian and needs to be updated
RUN apt-get --assume-yes install autoconf \
      automake \
      bc \
      doxygen \
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
      python-scipy \
      python-shapely \
      python-six \
      swig3.0 \
      texlive
