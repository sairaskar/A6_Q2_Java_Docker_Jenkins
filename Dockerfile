# Stage 1: Build
FROM eclipse-temurin:17-jdk AS build
COPY Java_Code.java .
RUN javac Java_Code.java

# Stage 2: Run
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build Java_Code.class .
CMD ["java", "Java_Code"]
