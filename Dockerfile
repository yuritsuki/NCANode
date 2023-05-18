FROM arm64v8/amazoncorretto:17-alpine3.16
EXPOSE 14579
WORKDIR /app
ARG artifact=build/libs/NCANode.jar
COPY $artifact /app/NCANode.jar
RUN mkdir /app/cache
VOLUME /app/cache
ENTRYPOINT ["java", "-jar", "NCANode.jar"]
HEALTHCHECK --interval=20s --timeout=30s --retries=7 \
    CMD wget -O - http://127.0.0.1:14579/actuator/health | grep -v DOWN || exit 1
