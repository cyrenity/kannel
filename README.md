docker-kannel-alpine
=============

Docker image for [Kannel SMS Gateway](http://kannel.org/)

# Usage #

### Create the network ###
```
docker network create kannelnet
```
### Run the bearerbox ###

```
docker run --rm -it --name bearerbox \
                    --hostname bearerbox \
                    --network kannelnet \
                    -p 13000:13000 -p 13001:13001 \
                    --volume /opt/conf:/etc \
                    kannel/gateway:1.4.5 \
                    bearerbox -v 2 /etc/kannel.conf
```
### Run the smsbox ###
```
docker run --rm -it --name smsbox \
                    --hostname smsbox \
                    --network kannelnet \
                    -p 13013:13013 \
                    --volumes-from bearerbox \
                    kannel/gateway:1.4.5 \
                    smsbox -v 2 /etc/kannel.conf  
```
## Notes ##
For your smsbox to be able to connect with the bearerbox, you first need to start the bearerbox. 
