FROM ligo/lalsuite-dev:el7

LABEL name="TESTING" \
      maintainer="NONE" \
      date="20180101" \
      support="NONE"

# install lalsuite dependencies
RUN yum -y install vim 

# clear package cache
RUN yum clean all
