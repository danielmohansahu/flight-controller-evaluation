# start from a base Ubuntu image with Nvidia support
FROM nvidia/cuda:11.4.0-base-ubuntu20.04 as base

# upgrade and install common utilites
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
      lsb-release wget gnupg vim gdb byobu build-essential \
    && rm -rf /var/lib/apt/lists/*

# install Ignition Gazebo
RUN wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" \
    | tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y gz-garden \
    && rm -rf /var/lib/apt/lists/*

# drop into a byobu shell
CMD byobu
