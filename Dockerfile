FROM ubuntu:16.04

LABEL maintainer "jechkoj@gmail.com"

RUN apt-get update && apt-get upgrade -y --no-install-recommends \
	clang \
	libicu-dev \
	libxml2 \
	libpython2.7 \
	ca-certificates \
	vim \
	curl && \
  	apt-get clean && \
 	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG SWIFT_PLATFORM=ubuntu16.04
ARG SWIFT_BRANCH=swift-4.0-release
ARG SWIFT_VERSION=swift-4.0-RELEASE

ENV SWIFT_PLATFORM=$SWIFT_PLATFORM \
    SWIFT_BRANCH=$SWIFT_BRANCH \
    SWIFT_VERSION=$SWIFT_VERSION	
	
RUN SWIFT_URL=https://swift.org/builds/$SWIFT_BRANCH/$(echo "$SWIFT_PLATFORM" | tr -d .)/$SWIFT_VERSION/$SWIFT_VERSION-$SWIFT_PLATFORM.tar.gz && \
	curl -fSL -o swift.tar.gz $SWIFT_URL && \ 
	curl -fSsL -o swift.tar.gz.sig $SWIFT_URL.sig && \
	export GNUPGHOME="$(mktemp -d)" && \
	set -e && curl -fSsL -o - https://swift.org/keys/all-keys.asc | gpg --import - && \
	gpg --quiet --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift && \
	gpg --quiet --batch --verify swift.tar.gz.sig swift.tar.gz && \
	tar -xzf swift.tar.gz --directory / --strip-components=1 && \
	rm -r "$GNUPGHOME" swift.tar.gz.sig swift.tar.gz && \
	chmod -R o+r /usr/lib/swift 
	
