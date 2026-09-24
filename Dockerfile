FROM debian:latest AS build-env

RUN apt-get update && apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3

RUN git clone https://github.com/flutter.git /usr/local/flutter

ENV PATH="/user/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter channel stable && flutter upgrade && flutter config --enable-web

RUN mkdir /app/

COPY . /app/

WORKDIR /app/

RUN flutter pub get

RUN flutter build web

FROM nginx:alpine

COPY --from=build-env /app/build/web /usr/share/nginx/html

EXPOSE 80

