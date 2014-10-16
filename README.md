# Dockerized Tor Relay server

A simple Docker container for running a Tor relay server. The container is configured to relay up to 750GB of data (each way) per month.

The container is also configured to listen on port 9001 for the relay traffic, and 9030 for the directory service. Make sure to open these in your firewall.

## Usage

Running the relay is super simple.

    $ sudo docker pull vpetersson/docker-torrelay
    $ sudo docker run -d \
        -p :9001:9001 \
        -p :9030:9030 \
        --restart=always \
        --name=torrelay \
        -t vpetersson/docker-torrelay
