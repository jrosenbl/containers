FROM debian:buster
RUN apt update && apt upgrade -y
RUN apt install -y emacs
RUN apt install -y git
COPY ./data/go/go* /tmp
# ADD https://golang.org/dl/go1.15.linux-amd64.tar.gz /tmp/
RUN tar -C /usr/local -xzf /tmp/go1.15.linux-amd64.tar.gz
RUN useradd -ms /bin/bash client
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GO111MODULE=on
ENV GOPATH="/home/client/"
RUN ["go", "get", "-v", "github.com/google/gnxi/..."]
WORKDIR /home/client/
RUN ["go", "install", "github.com/google/gnxi/..."]
RUN mkdir data
CMD ["/bin/bash"]

