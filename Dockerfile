FROM particle/buildpack-base:0.3.6

ENV BOOST_VERSION=1_59_0
ENV BOOST_HOME=$HOME/boost
ENV BOOST_ROOT=$BOOST_HOME/boost_$BOOST_VERSION
ENV LD_LIBRARY_PATH=$BOOST_ROOT/stage/lib:$LD_LIBRARY_PATH

RUN dpkg --add-architecture i386 \
  && apt-get update -q && apt-get install -qy gcc-4.9 g++-4.9 make isomd5sum libarchive-zip-perl libc6:i386 wget vim-common \
  && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 40 \
  && update-alternatives --install /usr/bin/cpp cpp /usr/bin/cpp-4.9 40 \
  && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 40 \
  && apt-get clean && apt-get purge \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY bin/install-boost /bin
RUN /bin/install-boost
COPY bin /bin
