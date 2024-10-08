FROM openjdk:17-jdk-slim

# Docker 이미지 내에 /app 디렉토리를 생성하여, 이후에 이 디렉토리를 사용할 수 있도록 준비
RUN mkdir /app
# Dockerfile 내에서 현재 작업 디렉토리를 /app으로 설정하여, 이후의 명령어(COPY, RUN, CMD 등)가 이 디렉토리 내에서 실행
WORKDIR /app

# Docker 빌드 프로세스 동안 사용할 수 있는 변수(빌드 아규먼트)를 정의
ARG JAR_FILE=build/libs/rainfall-0.0.1-SNAPSHOT.jar
# 로컬 파일 시스템에서 JAR_FILE 경로에 있는 JAR 파일을 Docker 이미지의 루트 디렉토리에 app.jar라는 이름으로 복사
COPY ${JAR_FILE} app.jar
#현재 디렉토리에 있는 wait-for-it.sh 파일을 Docker 이미지의 /app 디렉토리로 복사
COPY wait-for-it.sh /app/wait-for-it.sh
#/app/wait-for-it.sh 파일에 실행 권한을 부여
RUN chmod +x /app/wait-for-it.sh

# 컨테이너가 8080 포트를 통해 외부와 통신할 수 있도록 설정
EXPOSE 8080

# Docker 컨테이너가 시작될 때 실행되는 명령을 지정하는 명령어
# ["java", "-jar", "app.jar"]
# java: Java 실행 명령어입니다. Java 애플리케이션을 실행하는 데 사용
# jar: Java 옵션으로, JAR 파일을 실행하겠다는 의미
# app.jar: 실행할 JAR 파일의 이름, 이 JAR 파일은 Java 애플리케이션을 포함하고 있으며, java -jar app.jar 명령을 통해 실행
CMD ["sh", "-c", "/app/wait-for-it.sh db:3306 -- java -jar app.jar"]