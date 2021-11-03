FROM nvidia/cuda:11.4.2-devel-ubuntu20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    build-essential \
    software-properties-common \
    wget \ 
    git

# Install cmake
RUN  mkdir install && cd install && wget https://github.com/Kitware/CMake/releases/download/v3.21.4/cmake-3.21.4-linux-x86_64.sh \
  && sh cmake-3.21.4-linux-x86_64.sh --skip-license && cp bin/* /bin/ && cp -r share/* /usr/share/
# RUN  mkdir install && cd install && wget https://cmake.org/files/v3.20/cmake-3.20.6-linux-x86_64.sh \
#   && sh cmake-3.20.6-linux-x86_64.sh --skip-license && cp bin/* /bin/ && cp -r share/* /usr/share/
  
# RUN ./cmake-3.21.4-linux-x86_64.sh --skip-license
# RUN rm cmake-3.21.4-linux-x86_64.sh

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    python3-dev \
    python3-distutils

# Install GNU Radio Prerequisites
# CPP deps
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
         libad9361-0 \
         libasound2 \
         libboost-date-time1.71.0 \
         libboost-filesystem1.71.0 \
         libboost-program-options1.71.0 \
         libboost-thread1.71.0 \
         libfftw3-bin \
         libgmp10 \
         libgsl23 \
         libgtk-3-0 \
         libiio0 \
         libsoapysdr0.7 \
         soapysdr-tools \
         libjack-jackd2-0 \
         liblog4cpp5v5 \
         libpangocairo-1.0-0 \
         libportaudio2 \
         libqwt-qt5-6 \
         libsndfile1-dev \
         libsdl-image1.2 \
         libthrift-dev \
         libuhd3.15.0 \
         libusb-1.0-0 \
         libzmq5 \
         libpango-1.0-0 \
         gir1.2-gtk-3.0 \
         gir1.2-pango-1.0 \
         pkg-config \
         thrift-compiler \
         --no-install-recommends \
    && apt-get clean

# Py3 deps
RUN DEBIAN_FRONTEND=noninteractive \
       apt-get install -qy \
         pybind11-dev \
         python3-click \
         python3-click-plugins \
         python3-mako \
         python3-dev \
         python3-gi \
         python3-gi-cairo \
         python3-lxml \
         python3-numpy \
         python3-opengl \
         python3-pyqt5 \
         python3-yaml \
         python3-zmq \
         python3-six \
         python3-pytest \
         --no-install-recommends \
    && apt-get clean

# Build deps
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
       --no-install-recommends \
       build-essential \
       ccache \
       libad9361-dev \
       libboost-date-time-dev \
       libboost-dev \
       libboost-filesystem-dev \
       libboost-program-options-dev \
       libboost-regex-dev \
       libboost-system-dev \
       libboost-test-dev \
       libboost-thread-dev \
       libcppunit-dev \
       libfftw3-dev \
       libgmp-dev \
       libgsl0-dev \
       libiio-dev \
       libsoapysdr-dev \
       liblog4cpp5-dev \
       libspdlog-dev \
       libfmt-dev \
       libqwt-qt5-dev \
       qtbase5-dev \
       libsdl1.2-dev \
       libuhd-dev \
       libusb-1.0-0-dev \
       libzmq3-dev \
       portaudio19-dev \
       pyqt5-dev-tools \
    && apt-get clean

# Clean Up
RUN apt-get clean \
    && apt-get autoclean

# Install VOLK
RUN mkdir -p /src/build \
&& git clone --recursive https://github.com/gnuradio/volk.git /src/volk --branch v2.4.1 \
&& cd /src/build \
&& cmake -DCMAKE_BUILD_TYPE=Release ../volk/ \
&& make -j10\
&& make install \
&& cd / \
&& rm -rf /src/

# Install GNU Radio
RUN mkdir -p /src/build \
&& git clone https://github.com/gnuradio/gnuradio.git /src/gnuradio --branch master
RUN cd /src/gnuradio && git checkout 50d00f108c3ad62cd7beed6a4cbfdf4f0321c5aa \
&& wget https://github.com/gnuradio/gnuradio/pull/5265.diff && git apply 5265.diff
RUN cd /src/gnuradio && mkdir build && cd build && \
  cmake .. && make -j10 && make install


# Install gr-cuda
RUN git clone https://github.com/gnuradio/gr-cuda.git /src/gr-cuda --branch main \
&& cd /src/gr-cuda && mkdir build && cd build && \
  cmake .. && make -j10 && make install

# Install MatX
RUN mkdir -p /src/build && git clone https://github.com/NVIDIA/MatX /src/MatX
RUN cd /src/MatX && mkdir build && cd build && \
    cmake -DBUILD_TESTS=OFF -DBUILD_BENCHMARKS=OFF -DBUILD_EXAMPLES=OFF -DBUILD_DOCS=OFF .. && \
    make -j4 && make install

WORKDIR /workspace/code