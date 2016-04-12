FROM ubuntu 
RUN apt-get update
RUN apt-get install stress
ENTRYPOINT ["stress"]
