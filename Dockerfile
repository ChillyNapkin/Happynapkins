# --- build stage ---
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /src
RUN git clone https://github.com/pxlsspace/Pxls.git .
RUN mvn -q -DskipTests clean package

# --- runtime stage ---
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /src/target/pxls*.jar /app/pxls.jar
COPY pxls.conf /app/pxls.conf
COPY roles.conf /app/roles.conf
COPY palette.conf /app/palette.conf
EXPOSE 8080
CMD ["java","-Xms256m","-Xmx512m","-jar","/app/pxls.jar","/app/pxls.conf"]
