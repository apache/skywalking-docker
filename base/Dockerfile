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
ARG tag

FROM adoptopenjdk/openjdk11:alpine AS base
ARG version
RUN echo "Building Apache SkyWalking ${version}"
ENV SKYWALKING_VERSION=${version}

FROM base AS es6
RUN echo "This is the stage that build the es6 image"
ENV SKYWALKING_TGZ=apache-skywalking-apm-${SKYWALKING_VERSION}.tar.gz

FROM base AS es7
RUN echo "This is the stage that build the es7 image"
ENV SKYWALKING_TGZ=apache-skywalking-apm-es7-${SKYWALKING_VERSION}.tar.gz

FROM ${tag} AS build

ENV SKYWALKING_CLI_VERSION=0.5.0
ENV SKYWALKING_ASC=${SKYWALKING_TGZ}.asc
ENV SKYWALKING_SHA512=${SKYWALKING_TGZ}.sha512
ENV SKYWALKING_CLI_TGZ=skywalking-cli-$SKYWALKING_CLI_VERSION-bin.tgz
ENV SKYWALKING_CLI_ASC=${SKYWALKING_CLI_TGZ}.asc
ENV SKYWALKING_CLI_SHA512=${SKYWALKING_CLI_TGZ}.sha512

ENV SKYWALKING_HOME=/skywalking
RUN mkdir -p "${SKYWALKING_HOME}"
ENV TMPDIR=/tmp/sw
RUN mkdir -p "${TMPDIR}"
WORKDIR $TMPDIR

ENV SKYWALKING_TGZ_URLS \
        https://www.apache.org/dyn/closer.cgi?action=download&filename=skywalking/$SKYWALKING_VERSION/$SKYWALKING_TGZ \
        # if the version is outdated, we might have to pull from the dist/archive :/
	    https://www-us.apache.org/dist/skywalking/$SKYWALKING_VERSION/$SKYWALKING_TGZ \
	    https://www.apache.org/dist/skywalking/$SKYWALKING_VERSION/$SKYWALKING_TGZ \
	    https://archive.apache.org/dist/skywalking/$SKYWALKING_VERSION/$SKYWALKING_TGZ

ENV SKYWALKING_ASC_URLS \
        https://www.apache.org/dyn/closer.cgi?action=download&filename=skywalking/$SKYWALKING_VERSION/$SKYWALKING_ASC \
        # if the version is outdated, we might have to pull from the dist/archive :/
	    https://www-us.apache.org/dist/skywalking/$SKYWALKING_VERSION/$SKYWALKING_ASC \
	    https://www.apache.org/dist/skywalking/$SKYWALKING_VERSION/$SKYWALKING_ASC \
	    https://archive.apache.org/dist/skywalking/$SKYWALKING_VERSION/$SKYWALKING_ASC

ENV SKYWALKING_SHA512_URLS \
        https://www.apache.org/dyn/closer.cgi?action=download&filename=skywalking/$SKYWALKING_VERSION/$SKYWALKING_SHA512 \
        # if the version is outdated, we might have to pull from the dist/archive :/
	    https://www-us.apache.org/dist/skywalking/$SKYWALKING_VERSION/$SKYWALKING_SHA512 \
	    https://www.apache.org/dist/skywalking/$SKYWALKING_VERSION/$SKYWALKING_SHA512 \
	    https://archive.apache.org/dist/skywalking/$SKYWALKING_VERSION/$SKYWALKING_SHA512

ENV SKYWALKING_CLI_TGZ_URLS \
        https://www.apache.org/dyn/closer.cgi?action=download&filename=skywalking/cli/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_TGZ \
        # if the version is outdated, we might have to pull from the dist/archive :/
	    https://www-us.apache.org/dist/skywalking/cli/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_TGZ \
	    https://www.apache.org/dist/skywalking/cli/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_TGZ \
	    https://archive.apache.org/dist/skywalking/cli/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_TGZ

ENV SKYWALKING_CLI_ASC_URLS \
        https://www.apache.org/dyn/closer.cgi?action=download&filename=skywalking/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_ASC \
        # if the version is outdated, we might have to pull from the dist/archive :/
	    https://www-us.apache.org/dist/skywalking/cli/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_ASC \
	    https://www.apache.org/dist/skywalking/cli/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_ASC \
	    https://archive.apache.org/dist/skywalking/cli/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_ASC

ENV SKYWALKING_CLI_SHA512_URLS \
        https://www.apache.org/dyn/closer.cgi?action=download&filename=skywalking/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_SHA512 \
        # if the version is outdated, we might have to pull from the dist/archive :/
	    https://www-us.apache.org/dist/skywalking/cli/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_SHA512 \
	    https://www.apache.org/dist/skywalking/cli/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_SHA512 \
	    https://archive.apache.org/dist/skywalking/cli/$SKYWALKING_CLI_VERSION/$SKYWALKING_CLI_SHA512

RUN set -eux; \
	\
	apk add --no-cache --virtual .fetch-deps \
		gnupg \
		\
		ca-certificates \
		openssl \
	; \
	\
	wget --timeout=20 -O KEYS https://downloads.apache.org/skywalking/KEYS; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --import KEYS; \
	\
	success=; \
	for url in $SKYWALKING_TGZ_URLS; do \
		if wget --timeout=20  -O ${SKYWALKING_TGZ} "$url"; then \
			success=1; \
			break; \
		fi; \
	done; \
	[ -n "$success" ]; \
	\
	success=; \
	for url in $SKYWALKING_SHA512_URLS; do \
		if wget --timeout=20  -O ${SKYWALKING_SHA512} "$url"; then \
			success=1; \
			break; \
		fi; \
	done; \
	[ -n "$success" ]; \
	\
	cat ${SKYWALKING_SHA512} | sha512sum -c -; \
	\
	success=; \
	for url in $SKYWALKING_ASC_URLS; do \
		if wget --timeout=20  -O ${SKYWALKING_ASC} "$url"; then \
			success=1; \
			break; \
		fi; \
	done; \
	[ -n "$success" ]; \
	\
	gpg --batch --verify ${SKYWALKING_ASC} ${SKYWALKING_TGZ}; \
	tar -xvf ${SKYWALKING_TGZ} --strip-components=1 -C "${SKYWALKING_HOME}"; \
	rm -rf "${SKYWALKING_HOME}/bin/"; \
	success=; \
	for url in $SKYWALKING_CLI_TGZ_URLS; do \
		if wget --timeout=20  -O ${SKYWALKING_CLI_TGZ} "$url"; then \
			success=1; \
			break; \
		fi; \
	done; \
	[ -n "$success" ]; \
	\
	success=; \
	for url in $SKYWALKING_CLI_SHA512_URLS; do \
		if wget --timeout=20  -O ${SKYWALKING_CLI_SHA512} "$url"; then \
			success=1; \
			break; \
		fi; \
	done; \
	[ -n "$success" ]; \
	\
	cat ${SKYWALKING_CLI_SHA512} | sha512sum -c -; \
	\
	success=; \
	for url in $SKYWALKING_CLI_ASC_URLS; do \
		if wget --timeout=20  -O ${SKYWALKING_CLI_ASC} "$url"; then \
			success=1; \
			break; \
		fi; \
	done; \
	[ -n "$success" ]; \
	\
	gpg --batch --verify ${SKYWALKING_CLI_ASC} ${SKYWALKING_CLI_TGZ}; \
	tar -xvf ${SKYWALKING_CLI_TGZ}; \
    mkdir "${SKYWALKING_HOME}/bin/"; \
	mv skywalking-cli-${SKYWALKING_CLI_VERSION}-bin/bin/swctl-${SKYWALKING_CLI_VERSION}-linux-amd64 ${SKYWALKING_HOME}/bin/swctl; \
	chmod 755 ${SKYWALKING_HOME}/bin/*; \
	command -v gpgconf && gpgconf --kill all || :; \
	ls -la ${SKYWALKING_HOME};

FROM adoptopenjdk/openjdk11:alpine

LABEL maintainer="hanahmily@apache.org,tanjian@apache.org"

COPY --from=build /skywalking /skywalking

RUN apk add --no-cache \
    bash
