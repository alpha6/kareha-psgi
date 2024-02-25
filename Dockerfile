FROM perl:5.38-slim

RUN apt update && apt install -y starman cpanminus build-essential

WORKDIR /usr/src/app
RUN mkdir -p /usr/src/app
RUN mkdir -p /usr/src/app/res

COPY cpanfile /usr/src/app/

RUN cpanm -L perl5 -nq --installdeps .

ENV PERL5LIB /usr/src/app/perl5

COPY mode_message /usr/src/app/
COPY kareha.pl /usr/src/app/
COPY kareha.js /usr/src/app/
COPY kareha.ico /usr/src/app/
COPY admin.pl /usr/src/app/
COPY app.psgi /usr/src/app/
COPY wakautils.pl /usr/src/app/
COPY captcha.pl /usr/src/app/

RUN ls -la /usr/src/app/

CMD [ "starman", "-l", "0.0.0.0:5000", "./app.psgi" ]

EXPOSE 5000