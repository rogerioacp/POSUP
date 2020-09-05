From ubuntu:18.04 as POSUP
RUN apt-get update && apt-get install -y \
    g++ \
    libcurl4-openssl-dev \
    libprotobuf-dev \
    libssl-dev \
    make \
    module-init-tools \
    libtool
RUN apt-get update && apt-get install -y \
	libtool \
	libtool-bin

WORKDIR /opt/intel
COPY --from=sgx_builder:latest /linux-sgx/linux/installer/bin/*.bin ./
RUN ./sgx_linux_x64_psw*.bin --no-start-aesm
RUN sh -c 'echo yes | ./sgx_linux_x64_sdk_*.bin'

WORKDIR /opt/intel/sgxsdk/SampleCode/SampleEnclave
RUN SGX_DEBUG=0 SGX_MODE=HW SGX_PRERELEASE=1 make

RUN adduser -q --disabled-password --gecos "" --no-create-home sgxuser

COPY libtomcrypt/ libtomcrypt/
WORKDIR  /opt/intel/sgxsdk/SampleCode/SampleEnclave/libtomcrypt
RUN make -f makefile.shared
RUN make install

RUN apt-get update && apt-get install gdb -y
