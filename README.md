## What Is This?
This is my containerized [kube-aws](https://github.com/coreos/kube-aws/releases) tool from CoreOS. It includes the kube-aws, awscli and kubectl.

## How Do I Use It?
* Use this command: `sudo docker run --rm -it -e AWS_ACCESS_KEY_ID= -e AWS_SECRET_ACCESS_KEY= -e AWS_DEFAULT_REGION= -v $PWD:$PWD -w $PWD maksimru/docker-kube-aws`.
* This assumes you have the AWS environment variables used above set up on your container __host__ machine.
* This assumes you are starting from a path on the container host where you either have or want to create a kubernetes stack.
* You will land in bash. From there, you can use all the usual commands of kube-aws, kubectl, or awscli.

## Setup kubernetes cluster
1) Start docker container with all stuff using your AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY and AWS_DEFAULT_REGION
`sudo docker run --rm -it -e AWS_ACCESS_KEY_ID= -e AWS_SECRET_ACCESS_KEY= -e AWS_DEFAULT_REGION= -v $PWD:$PWD -w $PWD maksimru/docker-kube-aws`
2) Run `aws kms --region=us-east-1 create-key --description="kube-aws assets"`
copy kms-key-arn to the next step
3) Run `kube-aws init --cluster-name=mycluster --external-dns-name=mycluster.com --region=us-east-1 --availability-zone=us-east-1a --key-name=q360_legacy_cluster_staging --kms-key-arn="arn:aws:kms:us-east-1......."`
4) Run `kube-aws render` to produce TLS certs
5) Run `kube-aws validate --s3-uri s3://mycluster-bucket/cluster` to verify configuration and permissions
6) Run `kube-aws up --s3-uri s3://mycluster-bucket/cluster`
7) You can use generated kubeconfig to connect to kubectl using `kubectl --kubeconfig=kubeconfig proxy`

## Start kubectl proxy on your machine
1) Go to folder where your kubeconfig generated on previous step stored
2) Run `docker run --expose 800 -p 800:80 -v $PWD:$PWD -w $PWD maksimru/docker-kube-aws kubectl --kubeconfig=kubeconfig proxy`
3) Navigate to http://localhost:800/ui

## Custom version of kubectl and/or kube-aws
Use --build-arg or environment variables kube_aws_version and kubectl_version. Example:
`docker build --build-arg kube_aws_version=v0.9.6 --build-arg kubectl_version=v1.6.3 -t maksimru/docker-kube-aws .`