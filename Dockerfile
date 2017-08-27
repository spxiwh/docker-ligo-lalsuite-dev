FROM ligo/base:stretch

LABEL name="LALSuite Development - Debian Stretch" \
      maintainer="Adam Mercer <adam.mercer@ligo.org>" \
      date="20170830" \
      support="Best Effort"

# FIXME: this should use the lscsoft-lalsuite-dev meta-package but
# that is out of date on Debian and needs to be updated
RUN apt-get update && apt-get --assume-yes install autoconf \
      automake \
      bc \
      build-essential \
      ccache \
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
      python-scipy \
      python-shapely \
      python-six \
      python3-dev \
      python3-glue \
      python3-h5py \
      python3-healpy \
      python3-numpy \
      python3-scipy \
      python3-shapely \
      python3-six \
      swig3.0 \
      texlive
