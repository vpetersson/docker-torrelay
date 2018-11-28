# Dockerized Tor Relay Node
#
# VERSION               0.0.2

FROM ubuntu:16.04
MAINTAINER Viktor Petersson "vpetersson@wireload.net"

RUN echo "deb http://deb.torproject.org/torproject.org xenial main\ndeb-src http://deb.torproject.org/torproject.org xenial main" > /etc/apt/sources.list.d/tor.list

RUN gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 > tor.gpg
RUN apt-key add tor.gpg

# Finally install Tor
RUN apt update
RUN apt install sudo -y
RUN apt install tor -y

# Expose the main port
EXPOSE 9001

# Add a user
RUN useradd tor

# This is where the tor data is stored
VOLUME /home/tor/.tor

# Add launcher
ADD start.sh /start.sh

# Start Tor
CMD /start.sh
