# Stage 1: Build
FROM openjdk:17-jdk-slim AS build
COPY Java_Code.java .
RUN javac Java_Code.java

# Stage 2: Run
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build Java_Code.class .
CMD ["java", "Java_Code"]
