#text dockerFile

#importation de l'OS

FROM ubuntu:latest
ENV TZ=Europe/Kiev
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

MAINTAINER Post-it

RUN apt-get -yqq update

RUN apt-get install -yq nodejs npm
WORKDIR /opt/Post-it

ADD Post-it /opt/Post-it
WORKDIR /Opt/post-it

RUN npm install
RUN npm i vue
RUN npm i -g vue-cli
# RUN npm run dev
# RUN cd Post-it
# RUN npm run dev
