# Dockerized Tor Relay Node
#
# VERSION               0.0.2

FROM ubuntu:16.04
MAINTAINER Viktor Petersson "vpetersson@wireload.net"

#Get DEB
RUN echo "deb http://deb.torproject.org/torproject.org xenial main\ndeb-src http://deb.torproject.org/torproject.org xenial main" > /etc/apt/sources.list.d/tor.list

#Set GPG
RUN gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 && gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 > tor.gpg && apt-key add tor.gpg

# Finally install Tor
RUN apt update && apt install sudo tor -y && apt clean

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
