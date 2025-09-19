FROM eclipse-temurin:21-jre-alpine

# Instalar curl para health checks
RUN apk add --no-cache curl

# Crear directorio de trabajo
WORKDIR /app

# Copiar el JAR (se construye en GitHub Actions, no aquí)
COPY target/*.jar app.jar

# Exponer puerto
EXPOSE 8080

# Configuración JVM optimizada
ENV JAVA_OPTS="-Xmx350m -Xms128m -XX:+UseSerialGC -XX:MaxMetaspaceSize=64m"

# Comando de inicio simple
ENTRYPOINT java $JAVA_OPTS -jar app.jar