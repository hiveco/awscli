FROM python:3.5.1-slim

#
# Install the AWS CLI and dependencies.
# See https://github.com/aws/aws-cli/issues/143#issuecomment-167467320
#
RUN set -x; \
    apt-get update -qq; \
    apt-get install --no-install-recommends -qqy \
        groff \
        wget; \
    apt-get install -qqy \
        less; \
    rm -rf /var/lib/apt/lists/*; \
    pip install --upgrade pip; \
    pip install awscli

ENTRYPOINT ["/entrypoint.sh"]

ADD config.ini /root/.aws/config
ADD entrypoint.sh /
