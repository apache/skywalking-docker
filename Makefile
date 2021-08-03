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

TAG_SUFS := es6 es7

ROOT := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

D := docker
DC := docker-compose

BASE_BUILD_TARGETS := $(TAG_SUFS:%=base.%)
OAP_BUILD_TARGETS := $(TAG_SUFS:%=oap-server.%)
COMPLEX_BUILD_TARGETS := $(BASE_BUILD_TARGETS) $(OAP_BUILD_TARGETS)
COMPOSE_TARGETS := $(TAG_SUFS:%=compose.%)
BUILD_TARGETS := $(COMPLEX_BUILD_TARGETS) ui java-agent

word-dot = $(word $2,$(subst ., ,$1))

build: $(BUILD_TARGETS)

$(COMPLEX_BUILD_TARGETS):
	@echo "Building $@"
	$(eval repo := $(call word-dot,$@,1))
	$(eval imgTag := $(call word-dot,$@,2))
	pushd $(ROOT)/$(repo) \
	&& $(D) build $(SW_BUILD_ARGS) --build-arg version=$(SW_VERSION) --build-arg tag=$(imgTag) -t apache/skywalking-$(repo):${SW_VERSION}-${imgTag} . \
	&& popd

ui:
	@echo "Building ui"
	pushd $(ROOT)/ui \
	&& $(D) build $(SW_BUILD_ARGS) --build-arg version=$(SW_VERSION) -t apache/skywalking-ui:$(SW_VERSION) . \
	&& $(D) tag apache/skywalking-ui:$(SW_VERSION) apache/skywalking-ui:latest \
	&& popd


java-agent:
	$(MAKE) -C java-agent build


$(COMPOSE_TARGETS):
	@echo "Booting $@"
	$(eval imgTag := $(subst compose.,,$@))
	pushd $(ROOT)/compose \
	&& SW_VERSION=${SW_VERSION} $(DC) --env-file .env.${imgTag} up \
	&& popd

$(foreach TGT,$(COMPLEX_BUILD_TARGETS),$(eval push.$(TGT): ;\
	$(D) push apache/skywalking-$(call word-dot,$(TGT),1):${SW_VERSION}-$(call word-dot,$(TGT),2) ))

push.ui:
	$(D) push apache/skywalking-ui:$(SW_VERSION) \
	&& $(D) push  apache/skywalking-ui:latest

push.java-agent:
	$(MAKE) -C java-agent push

PUSH_TARGETS:=
$(foreach TGT,$(BUILD_TARGETS),$(eval PUSH_TARGETS+=push.$(TGT)))

docker.push: $(PUSH_TARGETS)

.PHONY: $(BUILD_TARGETS) $(COMPOSE_TARGETS) $(PUSH_TARGETS)
