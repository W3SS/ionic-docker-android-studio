FROM debian:jessie
MAINTAINER renannn[at]outlook[dot]com 

ENV DEBIAN_FRONTEND=noninteractive \
    ANDROID_STUDIO /opt/android-studio\
    ANDROID_STUDIO_VERSION 2.1.0.9 \
    ANDROID_STUDIO_URL https://dl.google.com/dl/android/studio/ide-zips/${ANDROID_STUDIO_VERSION}/android-studio-ide-143.2790544-linux.zip\
    NODE_VERSION=6.12.0 \
    NPM_VERSION=3.10.10 \
    IONIC_VERSION=3.19.0 \
    CORDOVA_VERSION=7.0.0 \
    YARN_VERSION=1.3.2 \
    # Fix for the issue with Selenium, as described here:
    # https://github.com/SeleniumHQ/docker-selenium/issues/87
    DBUS_SESSION_BUS_ADDRESS=/dev/null 

# Install basics 
RUN apt-get update &&  \
    apt-get install -y git wget curl unzip ruby build-essential xvfb && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get update &&  \
    apt-get install -y nodejs && \
    npm install -g npm@"$NPM_VERSION" cordova@"$CORDOVA_VERSION" ionic@"$IONIC_VERSION" yarn@"$YARN_VERSION" && \
    npm cache clear && \
    gem install sass && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg --unpack google-chrome-stable_current_amd64.deb && \
    apt-get install -f -y && \
    apt-get clean && \
    rm google-chrome-stable_current_amd64.deb && \
    mkdir Sources && \
    mkdir -p /root/.cache/yarn/ && \

WORKDIR Sources
EXPOSE 8100 35729
CMD ["ionic", "serve"]