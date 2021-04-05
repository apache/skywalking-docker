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

D := docker

TARGETS := alpine jdk8 jdk11
PUSH_TARGETS := $(TARGETS:%=push.%)

word-dot = $(word $2,$(subst ., ,$1))

build: $(TARGETS)
push: $(PUSH_TARGETS)

$(TARGETS):
	$(D) build $(SW_BUILD_ARGS) \
	--build-arg version=$(SW_VERSION) \
	--build-arg BASE_IMAGE=$(BASE_IMAGE) \
	--build-arg tag=$@ \
	-t apache/skywalking-java-agent:${SW_VERSION}-$@ \
	.

$(PUSH_TARGETS):
	$(eval version := $(call word-dot,$@,2))
	@(D) push apache/skywalking-java-agent:${SW_VERSION}-$(version) \

alpine: BASE_IMAGE=alpine

jdk8: BASE_IMAGE=adoptopenjdk/openjdk8:alpine

jdk11: BASE_IMAGE=adoptopenjdk/openjdk11:alpine
