# Apache SkyWalking OAP Server Docker Files

<img src="http://skywalking.apache.org/assets/logo.svg" alt="Sky Walking logo" height="90px" align="right" />

**SkyWalking**: an APM(application performance monitor) system, especially designed for 
microservices, cloud native and container-based (Docker, Kubernetes, Mesos) architectures.

# How to use this image

## Start a `standlone` container with `H2` storage

```
$ docker run --name oap --restart always -d apache/skywalking-oap-server:6.1.0
```

## Start a `standlone` container with `elasticsearch` storage whose address is `elasticsearch:9200`

```
$ docker run --name oap --restart always -d -e SW_STORAGE=elasticsearch -e SW_STORAGE_ES_CLUSTER_NODES=elasticsearch:9200 apache/skywalking-oap-server:6.1.0
```

# Configuration

We could setup enviroment variables to configure this image. Most of them is defined in [setup backends](), but Apache SkyWalking Docker Image adds extra enviroment variables to help user to compose it propertly.

## SW_CLUSTER
Default value is `standalone`, avaliable values are:
 - `standlone`
 - `zookeeper`
 - `kubernetes`
 - con
## SW_STORAGE
## XXX_ENABLED

# License
[Apache 2.0 License.](/LICENSE)
