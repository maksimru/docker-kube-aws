FROM alpine:3.5

RUN apk update && apk upgrade

RUN apk add \
	bash \
	ca-certificates \
	gnupg \
	groff \
	less \
	py-pip

RUN pip install awscli

RUN gpg2 --keyserver pgp.mit.edu --recv-key FC8A365E

ADD https://github.com/coreos/kube-aws/releases/download/v0.9.1/kube-aws-linux-amd64.tar.gz /temp/kube-aws/

ADD https://github.com/coreos/kube-aws/releases/download/v0.9.1/kube-aws-linux-amd64.tar.gz.sig /temp/kube-aws/

RUN gpg2 --verify /temp/kube-aws/kube-aws-linux-amd64.tar.gz.sig  /temp/kube-aws/kube-aws-linux-amd64.tar.gz

RUN tar --extract --gzip --file /temp/kube-aws/kube-aws-linux-amd64.tar.gz --directory /temp/kube-aws

RUN mv /temp/kube-aws/linux-amd64/kube-aws /usr/local/bin

RUN rm -r /temp/kube-aws

CMD bash
