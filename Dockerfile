FROM ubuntu:latest

RUN apt-get update && \
    apt-get -y install fortune cowsay 

RUN apt-get install -y netcat-openbsd
RUN cp -pr /usr/games/fortune /bin/fortune
RUN cp -pr /usr/games/cowsay /bin/cowsay

WORKDIR /app

COPY wisecow.sh /app/wisecow.sh

RUN chmod +x /app/wisecow.sh

EXPOSE 4499

CMD ["/app/wisecow.sh"]
