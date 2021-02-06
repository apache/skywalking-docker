
SW_VERSION ?= 8.4.0

TAG_SUFS := es6 es7


ROOT := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

D := docker
DC := docker-compose

BASE_BUILD_TARGETS := $(TAG_SUFS:%=base.%)
OAP_BUILD_TARGETS := $(TAG_SUFS:%=oap-server.%)
COMPLEX_BUILD_TARGETS := $(BASE_BUILD_TARGETS) $(OAP_BUILD_TARGETS)
COMPOSE_TARGETS := $(TAG_SUFS:%=compose.%)
BUILD_TARGETS := $(COMPLEX_BUILD_TARGETS) ui

word-dot = $(word $2,$(subst ., ,$1))

build: $(BUILD_TARGETS)

$(COMPLEX_BUILD_TARGETS):
	@echo "Building $@"
	$(eval repo := $(call word-dot,$@,1))
	$(eval imgTag := $(call word-dot,$@,2))
	pushd $(ROOT)/base \
	&& $(D) build --build-arg version=$(SW_VERSION) --build-arg tag=$(imgTag) -t apache/skywalking-$(repo):${SW_VERSION}-${imgTag} . \
	&& popd

ui:
	@echo "Building ui"
	pushd $(ROOT)/ui \
	&& $(D) build --build-arg version=$(SW_VERSION) -t apache/skywalking-ui:$(SW_VERSION) . \
	&& $(D) tag apache/skywalking-ui:$(SW_VERSION) apache/skywalking-ui:latest \
	&& popd

$(COMPOSE_TARGETS):
	@echo "Booting $@"
	$(eval imgTag := $(subst compose.,,$@))
	pushd $(ROOT)/compose \
	&& $(DC) --env-file .env.${imgTag} up \
	&& popd

$(foreach TGT,$(COMPLEX_BUILD_TARGETS),$(eval push.$(TGT): ;\
	$(D) push apache/skywalking-$(call word-dot,$(TGT),1):${SW_VERSION}-$(call word-dot,$(TGT),2) ))

push.ui:
	$(D) push apache/skywalking-ui:$(SW_VERSION) \
	&& $(D) push  apache/skywalking-ui:latest

PUSH_TARGETS:=
$(foreach TGT,$(BUILD_TARGETS),$(eval PUSH_TARGETS+=push.$(TGT)))

docker.push: $(DOCKER_PUSH_TARGETS)

.PHONY: $(BUILD_TARGETS) $(COMPOSE_TARGETS) $(PUSH_TARGETS)
