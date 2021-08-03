# Apache SkyWalking UI docker file

**Docker images are not official ASF releases but provided for convenience. Recommended usage is always to build the source**

<img src="http://skywalking.apache.org/assets/logo.svg" alt="Sky Walking logo" height="90px" align="right" />

**SkyWalking**: an APM(application performance monitor) system, especially designed for
microservices, cloud native and container-based (Docker, Kubernetes, Mesos) architectures.

[![GitHub stars](https://img.shields.io/github/stars/apache/skywalking.svg?style=for-the-badge&label=Stars&logo=github)](https://github.com/apache/skywalking)
[![Twitter Follow](https://img.shields.io/twitter/follow/asfskywalking.svg?style=for-the-badge&label=Follow&logo=twitter)](https://twitter.com/AsfSkyWalking)

You could find docker file at [here](https://github.com/apache/skywalking-docker)

This image would start up SkyWalking UI only.

[SkyWalking K8s deployment scripts](https://github.com/apache/skywalking-kubernetes) use this image by default.

# How to use this image

## Start a container to connect oap server whose address is `http://oap:12800`

```shell
$ docker run --name oap --restart always -d -e SW_OAP_ADDRESS=http://oap:12800 apache/skywalking-ui:8.3.0
```

# Configuration

We could set up environment variables to configure this image.

## SW_OAP_ADDRESS
The address of OAP server. Default value is `http://127.0.0.1:12800`.

# License
[Apache 2.0 License.](/LICENSE)
