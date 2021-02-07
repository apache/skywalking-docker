# Apache SkyWalking UI docker file

**Docker images are not official ASF releases but provided for convenience. Recommended usage is always to build the source**

<img src="http://skywalking.apache.org/assets/logo.svg" alt="Sky Walking logo" height="90px" align="right" />

**SkyWalking**: an APM(application performance monitor) system, especially designed for 
microservices, cloud native and container-based (Docker, Kubernetes, Mesos) architectures.

[![GitHub stars](https://img.shields.io/github/stars/apache/incubator-skywalking.svg?style=for-the-badge&label=Stars&logo=github)](https://github.com/apache/incubator-skywalking)
[![Twitter Follow](https://img.shields.io/twitter/follow/asfskywalking.svg?style=for-the-badge&label=Follow&logo=twitter)](https://twitter.com/AsfSkyWalking)

You could find docker file at [here](https://github.com/apache/incubator-skywalking-docker)

This image would start up SkyWalking UI only. 

[SkyWalking K8s deployment scripts](https://github.com/apache/incubator-skywalking-kubernetes) use this image by default.

# How to use this image

## Start a container to connect oap server whose address is `oap:12800`

```
$ docker run --name oap --restart always -d -e SW_OAP_ADDRESS=oap:12800 apache/skywalking-ui:6.2.0
```

# Configuration

We could set up environment variables to configure this image.

## SW_OAP_ADDRESS
The address of OAP server. Default value is `127.0.0.1:12800`.
 
## SW_TIMEOUT
Reading timeout. Default value is `20000`(millisecond).

# License
[Apache 2.0 License.](/LICENSE)