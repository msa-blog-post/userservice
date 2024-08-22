# 1. 기본 이미지
FROM openjdk:17-jdk-slim as build

# 2. 작업 디렉토리를 설정
WORKDIR /app

# 3. Gradle Wrapper 파일과 소스 코드 복사
COPY gradlew /app/gradlew
COPY gradle /app/gradle
COPY build.gradle.kts .
COPY settings.gradle.kts .
COPY src /app/src

# 4. Gradle Wrapper에 실행 권한 부여
RUN chmod +x gradlew

# 5. Gradle 빌드
RUN ./gradlew build --no-daemon

# 6. 실행 이미지를 설정
FROM openjdk:17-jdk-slim

# 7. 빌드된 애플리케이션 JAR 파일을 복사
COPY --from=build /app/build/libs/*.jar /app/app.jar

# 8. 애플리케이션을 실행
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
