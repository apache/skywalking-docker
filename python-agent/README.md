# Apache SkyWalking Python Agent docker file

**Docker images are not official ASF releases but provided for convenience. Recommended usage is always to build the
source**

<img src="http://skywalking.apache.org/assets/logo.svg" alt="SkyWalking logo" height="90px" align="right" />

**SkyWalking**: an APM(application performance monitor) system, especially designed for microservices, cloud native and
container-based (Docker, Kubernetes, Mesos) architectures.

[![GitHub stars](https://img.shields.io/github/stars/apache/skywalking.svg?style=for-the-badge&label=Stars&logo=github)](https://github.com/apache/skywalking)
[![Twitter Follow](https://img.shields.io/twitter/follow/asfskywalking.svg?style=for-the-badge&label=Follow&logo=twitter)](https://twitter.com/AsfSkyWalking)

You could find the docker file [here](https://github.com/apache/skywalking-docker)

This image hosts the SkyWalking Python agent package on top of official Python base images providing support from 
Python 3.5 - 3.9.

# How to use this image

## Build your Python application image on top of this image

```dockerfile
FROM apache/skywalking-python:0.7.0-grpc-py3.9

# ... build your Python application
```

You should start your Python application with `CMD`, 

For example - `CMD ['gunicorn', 'app.wsgi']` 

you don't need to care about enabling the SkyWalking Python agent manually, 
it should be adopted and bootstrapped automatically through the `sw-python` CLI.

# License

[Apache 2.0 License.](/LICENSE)
