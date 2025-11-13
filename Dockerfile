FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    apt-utils \
    ca-certificates \
    git \
    git-core \
    libncurses-dev \
    make \
    python3 \
    unzip \
    wget \
    xz-utils \
    zip \
    python3 \
    python3-pip \
    python3-pexpect \
    python3-git \
    python3-jinja2 \
    locales \
    locales-all \
    chrpath \
    cpio \
    diffstat \
    gawk \
    iputils-ping \
    python3-distutils \
    gcc-multilib \
    build-essential \
    socat \
    debianutils \
    xterm \
    vim \
    bc \
    tmux \
    git-lfs \
    liblz4-tool \
    zstd \
    ca-certificates \
    cmake \
    ninja-build \
    python3-pyelftools \
   && apt-get autoremove -y \
   && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.17.4/zephyr-sdk-0.17.4_linux-x86_64_minimal.tar.xz && tar xvf zephyr-sdk-0.17.4_linux-x86_64_minimal.tar.xz -C /usr/local
RUN /usr/local/zephyr-sdk-0.17.4/setup.sh -t all -c


RUN pip3 install west
RUN pip3 install pylint

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["cd /workspace/ && west build -p -b sam_e54_xpro zephyr-microchip-sample.git/app"]
