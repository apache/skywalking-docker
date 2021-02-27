# Apache SkyWalking OAP Server Docker Files

<img src="http://skywalking.apache.org/assets/logo.svg" alt="Sky Walking logo" height="90px" align="right" />

**SkyWalking**: an APM(application performance monitor) system, especially designed for 
microservices, cloud native and container-based (Docker, Kubernetes, Mesos) architectures.

# Notice

This image can only connect to Elasticsearch **6** when setting `SW_STORAGE`=`elasticsearch`.

# How to use this image

## Start a `standlone` container with `H2` storage

```shell
$ docker run --name oap --restart always -d apache/skywalking-oap-server:8.3.0-es6
```

## Start a `standlone` container with `elasticsearch7` storage whose address is `elasticsearch:9200`

```shell
$ docker run --name oap --restart always -d -e SW_STORAGE=elasticsearch7 -e SW_STORAGE_ES_CLUSTER_NODES=elasticsearch:9200 apache/skywalking-oap-server:8.3.0-es7
```

# Configuration

We could set up environment variables to configure this image. They are defined in [backend-setup](https://skywalking.apache.org/docs/main/latest/en/setup/backend/backend-setup/).

# Extend image

If you intend to override or add config files in `/skywalking/config`, `/skywalking/ext-config` is the location for you to put extra files.
The files with the same name will be overridden, otherwise, they will be added in `/skywalking/config`.

If you want to add more libs/jars into the classpath of OAP, for example, new metrics for OAL. These jars can be mounted into `/skywalking/ext-libs`, then
`entrypoint` bash will append them into the classpath. Notice, you can't override an existing jar in classpath.

# License
[Apache 2.0 License.](/LICENSE)
