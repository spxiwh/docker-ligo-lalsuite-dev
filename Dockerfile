FROM spxiwh/docker-ligo-lalsuite-dev:jessie

LABEL name="TESTING" \
      maintainer="Ian Harry <ian.harry@ligo.org>" \
      date="20180103" \
      support="NONE"

RUN apt-get --assume-yes update
RUN apt-get --assume-yes upgrade
RUN apt-get --assume-yes install curl
RUN mkdir -p /TEMP/lalsuite_extra && cd /TEMP/lalsuite_extra && curl http://software.ligo.org/lscsoft/source/lalsuite-extra-1.3.0.tar.gz > lalsuite-extra-1.3.0.tar.gz
RUN cd /TEMP/lalsuite_extra && tar -zxvf lalsuite-extra-1.3.0.tar.gz && cd lalsuite-extra-1.3.0/data/lalsimulation && mkdir -p /usr/share/lalsimulation/ && cp * /usr/share/lalsimulation/

RUN mkdir -p /ROQ_data && cd /ROQ_data && curl https://minerva.aei.mpg.de/~mpuer/ROQ/32s/bases_32s.tar > bases_32s.tar && tar -xvf bases_32s.tar && rm -f bases_32s.tar
