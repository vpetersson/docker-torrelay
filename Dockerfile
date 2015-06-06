# Dockerized Tor Relay Node
#
# VERSION               0.0.1

FROM ubuntu:14.04
MAINTAINER Viktor Petersson "vpetersson@wireload.net"

# Install Tor
RUN apt-get update && echo 'deb http://deb.torproject.org/torproject.org trusty main' >> /etc/apt/sources.list && gpg --keyserver keys.gnupg.net --recv 886DDD89 && gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add - && apt-get update && apt-get -y install tor && apt-get clean

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
