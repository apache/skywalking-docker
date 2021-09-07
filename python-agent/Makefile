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

P := grpc http kafka

TARGETS := py3.5 py3.6 py3.7 py3.8 py3.9

py3.5: VERSION = 3.5
py3.6: VERSION = 3.6
py3.7: VERSION = 3.7
py3.8: VERSION = 3.8
py3.9: VERSION = 3.9

PUSH_TARGETS := $(TARGETS:%=push-%)

word-dash = $(word $2,$(subst -, ,$1))

build: $(TARGETS)
push: $(PUSH_TARGETS)

$(TARGETS):
	for p in $(P); do \
		$(D) build $(SW_BUILD_ARGS) \
				--build-arg SW_PYTHON_VERSION=$(VERSION) \
				--build-arg SW_PTTHON_PROTOCOL=$$p \
				-t apache/skywalking-python:${SW_PYTHON_AGENT_VERSION}-$$p-$@ \
				. ; \
	done


$(PUSH_TARGETS):
	$(eval version := $(call word-dash,$@,2))
	for p in $(P); do \
		$(D) push apache/skywalking-python:${SW_PYTHON_AGENT_VERSION}-$$p-${version}; \
	done
