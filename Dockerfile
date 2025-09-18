# Usar imagen base con OpenJDK 21
FROM openjdk:21-jre-slim

# Instalar curl para health checks y eliminar el cache
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
WORKDIR /app

# Copiar el JAR (se construye en GitHub Actions, no aquí)
COPY target/*.jar app.jar

# Exponer puerto
EXPOSE 8080

# Configuración JVM optimizada para t2.micro (máximo 400MB heap)
ENV JAVA_OPTS="-Xmx400m -Xms200m -XX:+UseG1GC -XX:MaxGCPauseMillis=200"

# Comando de inicio simple
ENTRYPOINT java $JAVA_OPTS -jar app.jar