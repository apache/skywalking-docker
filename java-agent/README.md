# Apache SkyWalking Agent docker file

**Docker images are not official ASF releases but provided for convenience. Recommended usage is always to build the
source**

<img src="https://skywalking.apache.org/assets/logo.svg" alt="Sky Walking logo" height="90px" align="right" />

**SkyWalking**: an APM(application performance monitor) system, especially designed for microservices, cloud native and
container-based (Docker, Kubernetes, Mesos) architectures.

[![GitHub stars](https://img.shields.io/github/stars/apache/skywalking.svg?style=for-the-badge&label=Stars&logo=github)](https://github.com/apache/skywalking)
[![Twitter Follow](https://img.shields.io/twitter/follow/asfskywalking.svg?style=for-the-badge&label=Follow&logo=twitter)](https://twitter.com/AsfSkyWalking)

You could find docker file at [here](https://github.com/apache/skywalking-docker)

This image only hosts the pre-built SkyWalking Java agent jars, and provides some convenient configurations for
containerization scenarios.

# How to use this image

## Build your Java application image on top of this image

```dockerfile
FROM apache/skywalking-java-agent:8.5.0-jdk8

# ... build your java application
```

You can start your Java application with `CMD` or `ENTRYPOINT`, but you don't need to care about the Java options to
enable SkyWalking agent, it should be adopted automatically.

## Use this image as sidecar of Kubernetes service

In Kubernetes scenarios, you can also use this agent image as a sidecar.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: agent-as-sidecar
spec:
  restartPolicy: Never

  volumes:
    - name: skywalking-agent
      emptyDir: { }

  containers:
    - name: agent-container
      image: apache/skywalking-java-agent:8.4.0-alpine
      volumeMounts:
        - name: skywalking-agent
          mountPath: /agent
      command: [ "/bin/sh" ]
      args: [ "-c", "cp -R /skywalking/agent /agent/" ]

    - name: app-container
      image: springio/gs-spring-boot-docker
      volumeMounts:
        - name: skywalking-agent
          mountPath: /skywalking
      env:
        - name: JAVA_TOOL_OPTIONS
          value: "-javaagent:/skywalking/agent/skywalking-agent.jar"
```

# License

[Apache 2.0 License.](/LICENSE)
