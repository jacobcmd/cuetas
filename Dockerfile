FROM openjdk:20-jdk

# Configurar el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo pom.xml y los archivos de configuración de Maven
COPY pom.xml ./
COPY mvnw ./
COPY mvnw.cmd ./
COPY .mvn .mvn

# Cambiar los permisos para permitir la ejecución de mvnw
RUN chmod +x mvnw

# Descargar las dependencias del proyecto
RUN ./mvn clean package

# Copiar el código fuente de la aplicación
COPY src ./src

# Compilar la aplicación
RUN ./mvnw package -DskipTests

# Exponer el puerto en el que se ejecutará la aplicación
EXPOSE 8083

# Ejecutar la aplicación
CMD ["java", "-jar", "target/cuentas-0.0.1-SNAPSHOT.jar"]
