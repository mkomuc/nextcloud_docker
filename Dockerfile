FROM nextcloud:apache
#RUN apt-get update \
# && apt-get install smbclient

RUN apt-get update \
 && apt -y install libmagickcore-6.q16-6-extra smbclient iputils-ping nmap mc btop net-tools ncdu java-common default-jre graphicsmagick ffmpeg ghostscript lsb-release \
    && echo "deb http://ftp.debian.org/debian $(lsb_release -cs) non-free" >> \
       /etc/apt/sources.list.d/intel-graphics.list && \
    apt-get update && \
    apt-get install -y intel-media-va-driver-non-free && \
    rm -rf /var/lib/apt/lists/*

# Enable QSV support
SHELL ["/bin/bash", "-c"]
RUN apt-get update && \
    apt-get install -y sudo curl git && \
    rm -rf /var/lib/apt/lists/*
RUN curl https://gist.githubusercontent.com/pulsejet/4d81c1356703b2c8ba19c1ca9e6f6e50/raw/qsv-docker.sh | bash


COPY start.sh /
CMD /start.sh
