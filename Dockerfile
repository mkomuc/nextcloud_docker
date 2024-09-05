FROM nextcloud:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && apt-get install -y --no-install-recommends lsb-release \
 && echo "deb http://ftp.debian.org/debian $(lsb_release -cs) non-free" >> \
    /etc/apt/sources.list.d/intel-graphics.list \
 && DEBIAN_FRONTEND=noninteractive apt-get update \
 && apt-get install -y --no-install-recommends \
    keyboard-configuration \
    libmagickcore-6.q16-6-extra \
    graphicsmagick \
    intel-media-va-driver-non-free \
    sudo \
    curl \
    git \
 && curl https://gist.githubusercontent.com/pulsejet/4d81c1356703b2c8ba19c1ca9e6f6e50/raw/qsv-docker.sh | bash \
 && rm -rf /var/lib/apt/lists/*

ENV NEXTCLOUD_UPDATE=1

COPY --chmod=0755 start.sh /
CMD /start.sh
