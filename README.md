# AWS CLI in Docker

Run the AWS CLI without needing to install any dependencies, thanks to Docker!

## Quick Start

To install, run this one-liner on your Linux system:

```
sudo curl -sL https://raw.githubusercontent.com/hiveco/awscli/master/aws.sh -o /usr/local/bin/aws; \
sudo chmod +x /usr/local/bin/aws
```

From now on, invoking `aws` will run `hiveco/awscli` in a container, using AWS credentials from the config file in your home directory. The `us-east-1` region will be auto-selected. To use a different region, set the `AWS_DEFAULT_REGION` environment variable using your favourite method.

Using this convenience script also automatically mounts the current directory under `/here`, which is useful for running commands like `aws s3 cp`.

## Credentials

Add your credentials to `~/.aws/credentials` as follows:

```
AWS_ACCESS_KEY_ID=<key-id>
AWS_SECRET_ACCESS_KEY=<secret-key>
cat << 'EOF' > ~/.aws/credentials
[default]
aws_access_key_id=$AWS_ACCESS_KEY_ID
aws_secret_access_key=$AWS_SECRET_ACCESS_KEY
EOF
```

## Advanced Usage

Run the `hiveco/awscli` container directly to be able to set the AWS credentials explicitly, or to enable auto-detection of the AWS region when running on an EC2 instance.

Specify AWS credentials with environment variables:

```
docker run -it --rm \
	-e AWS_ACCESS_KEY_ID=<key-id> \
	-e AWS_SECRET_ACCESS_KEY=<secret-key> \
	hiveco/awscli \
		[tool] [commands...]
```

The current region will be auto-detected from EC2 metadata. If not running on EC2, the tool will default to `us-east-1`. To explicitly specify a region, add a `-e AWS_DEFAULT_REGION=<region>` argument.

Specify AWS credentials with a config file (see the link below for the required format):

```
docker run -it --rm \
	-v <path-to-credentials-config>:/root/.aws/credentials \
	hiveco/awscli \
		[tool] [commands...]
```

## References

* [Command reference](http://docs.aws.amazon.com/cli/latest/)
* [Config file format reference](https://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html)
