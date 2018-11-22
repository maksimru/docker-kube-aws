FROM alpine:3.5

ARG kube_aws_version
ENV kube_aws_version ${kube_aws_version:-v0.12.0}

ARG kubectl_version
ENV kubectl_version ${kubectl_version:-v1.11.3}

RUN apk update && apk upgrade

RUN apk add \
	bash \
	ca-certificates \
	gnupg \
	groff \
	less \
	py-pip

RUN pip install awscli

ADD https://github.com/coreos/kube-aws/releases/download/$kube_aws_version/kube-aws-linux-amd64.tar.gz /temp/kube-aws/

RUN tar --extract --gzip --file /temp/kube-aws/kube-aws-linux-amd64.tar.gz --directory /temp/kube-aws

RUN mv /temp/kube-aws/linux-amd64/kube-aws /usr/local/bin

RUN rm -r /temp/kube-aws

ADD https://storage.googleapis.com/kubernetes-release/release/$kubectl_version/bin/linux/amd64/kubectl /usr/local/bin/

RUN chmod +x /usr/local/bin/kubectl

CMD bash
