# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM openjdk:8-jre-alpine AS build

LABEL maintainer="hanahmily@apache.org"

# Install required packages
RUN apk add --no-cache \
    bash \
    python \
    su-exec


ENV SKYWALKING_HOME=/skywalking
RUN mkdir -p "${SKYWALKING_HOME}"
WORKDIR $SKYWALKING_HOME

ENV GPG_KEYS A968F6905E0ACB59E5B24C15D3D9CD50820184C2 B0801BC746F965029A1338072EF5026E70A55777 D360AB2AB20B28403270E2CBE8608938DB25E06B
ENV SKYWALKING_VERSION=6.2.0
ENV SKYWALKING_SHA512 753cd9cfeca258cb31355be9c6f8d7e234a488b29b20d1f0e8b3c89c404bcf4fce49fa825c5cb674a42d56e8dc3947b9592b3c8d96c82df84b3926eb341481a6

ENV SKYWALKING_TGZ_URLS \
        https://www.apache.org/dyn/closer.cgi?action=download&filename=skywalking/$SKYWALKING_VERSION/apache-skywalking-apm-$SKYWALKING_VERSION.tar.gz \
        # if the version is outdated, we might have to pull from the dist/archive :/
	    https://www-us.apache.org/dist/skywalking/$SKYWALKING_VERSION/apache-skywalking-apm-$SKYWALKING_VERSION.tar.gz \
	    https://www.apache.org/dist/skywalking/$SKYWALKING_VERSION/apache-skywalking-apm-$SKYWALKING_VERSION.tar.gz \
	    https://archive.apache.org/dist/skywalking/$SKYWALKING_VERSION/apache-skywalking-apm-$SKYWALKING_VERSION.tar.gz

ENV SKYWALKING_ASC_URLS \
        https://www.apache.org/dyn/closer.cgi?action=download&filename=skywalking/$SKYWALKING_VERSION/apache-skywalking-apm-$SKYWALKING_VERSION.tar.gz.asc \
        # if the version is outdated, we might have to pull from the dist/archive :/
	    https://www-us.apache.org/dist/skywalking/$SKYWALKING_VERSION/apache-skywalking-apm-$SKYWALKING_VERSION.tar.gz.asc \
	    https://www.apache.org/dist/skywalking/$SKYWALKING_VERSION/apache-skywalking-apm-$SKYWALKING_VERSION.tar.gz.asc \
	    https://archive.apache.org/dist/skywalking/$SKYWALKING_VERSION/apache-skywalking-apm-$SKYWALKING_VERSION.tar.gz.asc

RUN set -eux; \
	\
	apk add --no-cache --virtual .fetch-deps \
		gnupg \
		\
		ca-certificates \
		openssl \
	; \
	\
	export GNUPGHOME="$(mktemp -d)"; \
	for key in $GPG_KEYS; do \
		gpg --batch --keyserver pgp.surfnet.nl --recv-keys "$key"; \
	done; \
	\
	success=; \
	for url in $SKYWALKING_TGZ_URLS; do \
		if wget -O skywalking.tar.gz "$url"; then \
			success=1; \
			break; \
		fi; \
	done; \
	[ -n "$success" ]; \
	\
	echo "$SKYWALKING_SHA512 *skywalking.tar.gz" | sha512sum -c -; \
	\
	success=; \
	for url in $SKYWALKING_ASC_URLS; do \
		if wget -O skywalking.tar.gz.asc "$url"; then \
			success=1; \
			break; \
		fi; \
	done; \
	[ -n "$success" ]; \
	\
	gpg --batch --verify skywalking.tar.gz.asc skywalking.tar.gz; \
	tar -xvf skywalking.tar.gz --strip-components=1; \
	rm -rf bin/; \
	rm skywalking.tar.gz*; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME"; \
    apk del .fetch-deps

FROM openjdk:8-jre-alpine

COPY --from=build /skywalking /skywalking

RUN apk add --no-cache \
    bash