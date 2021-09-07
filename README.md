# Apache SkyWalking Docker Files

<img src="https://skywalking.apache.org/assets/logo.svg" alt="Sky Walking logo" height="90px" align="right" />

**SkyWalking**: an APM(application performance monitor) system, especially designed for 
microservices, cloud native and container-based (Docker, Kubernetes, Mesos) architectures.

# Images
This repository includes related files of following docker images:
 - OAP server
 - UI
 - Java agent
 
 Documents of each version are in `v-x.y.z/oap` and `v-x.y.z/ui`. Such as [8.1.0 OAP](archive/8/8.1.0/oap) and [8.1.0 UI](archive/8/8.1.0/ui)

The convenience images are published to Docker Hub and available from the `skywalking.docker.scarf.sh` endpoint.

- `skywalking.docker.scarf.sh/apache/skywalking-base` ([Docker Hub](https://hub.docker.com/r/apache/skywalking-base))
- `skywalking.docker.scarf.sh/apache/skywalking-ui` ([Docker Hub](https://hub.docker.com/r/apache/skywalking-ui))
- `skywalking.docker.scarf.sh/apache/skywalking-oap-server` ([Docker Hub](https://hub.docker.com/r/apache/skywalking-oap-server))

Java agent images are available too.
- `skywalking.docker.scarf.sh/apache/skywalking-java-agent` ([Docker Hub](https://hub.docker.com/r/apache/skywalking-java-agent))

# How to build

## OAP and UI

When the version < `8.4.0`, the release manifests are grouping by their major version number and full version number in `archive`.

From `8.4.0`, issuing follows to build relevant docker images

```sh
# source 8/v8.4.0.sh if the target version is 8.4.0
source <major_version>/v<version>.sh

make
```

## Java Agent



# How to publish images

After a SkyWalking's Apache release, composing a new version environment setting script to `<major_version>` folder with the name like `v<version>.sh`

Building images as below:

```sh
source <major_version>/v<version>.sh
make
```

Verifying images:

```sh
# Booting up a compose of ES6, OAP server and UI
make compose.es6
# Booting up a compose of ES7, OAP server and UI
make compose.es7
```

Pushing built images to docker hub repos:

```sh
make docker.push
```

# How to build images before 8.4.0

The manifests building images before 8.4.0 are archived into `archive` folder.

These "archived" images could not be built by any `make` target, being built manually instead. 
The approach is that navigating to the target based on the path grouped by SkyWalking release version number
, then building specific images by `docker build`.

# License
[Apache 2.0 License.](/LICENSE)
