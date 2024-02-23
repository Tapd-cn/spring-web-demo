FROM maven:3-jdk-8-alpine

WORKDIR /tmp
RUN curl -o kona_jdk.tar.gz -s https://test-1251542635.cos.ap-guangzhou.myqcloud.com/TencentKona8.0.17.b1_jdk_linux-musl-x86_64_8u402.tar.gz && \
mkdir /usr/lib/jvm/java-1.8-konajdk && \
tar -zxf kona_jdk.tar.gz -C /usr/lib/jvm/java-1.8-konajdk --strip-components 1 && \
unlink /usr/lib/jvm/default-jvm && \
ln -s /usr/lib/jvm/java-1.8-konajdk /usr/lib/jvm/default-jvm && \
rm -rf /usr/lib/jvm/java-1.8-openjdk /tmp/kona_jdk.tar.gz

ARG jarname
WORKDIR /usr/src/app

COPY target/${jarname} /usr/src/app

ENV jarname ${jarname}
ENV PORT 5000
EXPOSE $PORT

CMD [ "sh", "-c", "java -Dserver.port=${PORT} -jar /usr/src/app/${jarname}" ]
