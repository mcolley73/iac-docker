FROM alpine:3.7

COPY terraform-0.11.7 /usr/bin/terraform

RUN set -ex \
  && apk --update add sudo \
  && apk --update add openssh \
  && apk --update add python py-pip openssl ca-certificates sshpass \
  && apk --update add groff \
  && apk --update add krb5 krb5-dev \
  && apk --update add libxml2-dev libxslt-dev \
  && apk --update add curl \
  && apk --update add git \
  && apk --update add unzip \
  && apk --update add --virtual build-dependencies python-dev libffi-dev openssl-dev build-base linux-headers musl-dev \
  && git config --global http.sslVerify false \
  && pip install --trusted-host pypi.python.org --upgrade cffi \
  && pip install --trusted-host pypi.python.org --upgrade pynacl \
  && pip install --trusted-host pypi.python.org --trusted-host github.com git+https://github.com/ansible/ansible.git@devel \
  && pip install --trusted-host pypi.python.org --upgrade pbr \
  && pip install --trusted-host pypi.python.org --upgrade "azure>=2.0.0" --upgrade --ignore-installed six \
  && pip install --trusted-host pypi.python.org \
      "ansible" \
      "boto" \
      "boto3" \
      "awscli" \
      "dopy" \
      "six" \
      "azure-cli" \
      "msrestazure" \
      "cs>=0.6.10" \
      "docker-py>=1.7.0" \
      "python-consul" \
      "requests" \
      "packaging" \
      "kazoo>=2.1" \
      "pywinrm" \
      "kerberos" \
      "requests_kerberos" \
      'python-jenkins' \
      'lxml' \
  && pip install --trusted-host pypi.python.org "pywinrm[kerberos]" \
  && apk del build-dependencies \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /etc/ansible \
  && mkdir -p /var/log \
  && echo 'localhost' > /etc/ansible/hosts \
  && pip list

# COPY krb5.conf /etc
WORKDIR /workspace
EXPOSE 5986

ENV ANSIBLE_HOST_KEY_CHECKING=false
ENV PAGER='more'
ENV HTTP_PROXY ''
ENV HTTPS_PROXY ''
ENV http_proxy ''
ENV https_proxy ''