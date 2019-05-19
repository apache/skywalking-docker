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

We could set up environment variables to configure this image. Most of them are defined in [backend-setup](https://github.com/apache/skywalking/blob/v6.1.0/docs/en/setup/backend/backend-setup.md), but Apache SkyWalking Docker Image adds extra environment variables to help the user to compose it properly. The details are located in [docker-entrypoint.sh](docker-entrypoint.sh)

## SW_CLUSTER
Default value is `standalone`, avaliable values are:

 - `standlone`, If set this value, all enviroment variables of `cluster.standlone` in `application.yml` are avaliable.
 - `zookeeper`, If set this value, all enviroment variables of `cluster.zookeeper` in `application.yml` are avaliable.
 - `kubernetes`, If set this value, all enviroment variables of `cluster.kubernetes` in `application.yml` are avaliable.
 - `consul`, If set this value, all enviroment variables of `cluster.consul` in `application.yml` are avaliable.
 
## SW_STORAGE
Default value is `H2`, avaliable values are:

 - `H2`, If set this value, all enviroment variables of `storage.h2` in `application.yml` are avaliable.
 - `elasticsearch`, If set this value, all enviroment variables of `stroage.elasticsearch` in `application.yml` are avaliable.
 - `mysql`, If set this value, all enviroment variables of `stroage.mysql` in `application.yml` are avaliable.
 
## XXX_ENABLED

There are also some other configuration switchers to extend default configuration, they also have a suffix `_ENABLED`.

 - `SW_RECEIVER_ZIPKIN_ENABLED` turns on/off zipkin receiver
 - `SW_RECEIVER_JAEGER_ENABLED` turns on/off jaeger receiver
 - `SW_EXPORTER_ENABLED`  turns on/off exporter

# License
[Apache 2.0 License.](/LICENSE)
