#obraz bazowy scratch
FROM scratch as builder
ADD alpine-minirootfs-3.19.1-aarch64.tar /

#curl install
RUN apk add --update curl && \
rm -rf /ar/cache/apk/*

#node install
RUN apk add --no-cache nodejs npm

#ustawienie katalogu roboczego
WORKDIR /app

#kopiowanie plikow do kontenera
COPY ./index.js .
COPY ./package.json .

#instalacja npm i biblioteki moment-timezone, do ustawienia strefy czasowej
RUN npm install
RUN npm install moment-timezone

LABEL author="Jakub Sikora"

#obraz bazowy nginx
FROM nginx:alpine

#node install
RUN apk add --update nodejs

#kopiowanie plikow aplikacji z I etapu do kontenera
COPY --from=builder /app /app

#ustawienie portu na 8081
EXPOSE 8081

#stan zdrowia przez curla
HEALTHCHECK --interval=10s --timeout=1s \
    CMD curl -f http://localhost:8081/ || exit 1

CMD ["sh", "-c", "nginx & node /app/index.js"]
