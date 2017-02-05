## What Is This?
This is my containerized [kube-aws](https://github.com/coreos/kube-aws/releases) tool from CoreOS. It includes the awscli and kubectl.

## How Do I Use It?
* Use this command: `sudo docker run --rm -it -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION -v $PWD:$PWD -w $PWD hackenfreude/kube-aws`.
* This assumes you have the AWS environment variables used above set up on your container __host__ machine.
* This assumes you are starting from a path on the container host where you either have or want to create a kubernetes stack.
* You will land in bash. From there, you can use all the usual commands of kube-aws, kubectl, or awscli.
