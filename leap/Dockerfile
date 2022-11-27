# Source
FROM opensuse/leap:latest

ENV container="docker"
ARG pip_packages="ansible"

# Install software and update
RUN zypper --non-interactive dup && \
  # Install OS identifiers
  zypper --non-interactive install --no-confirm openSUSE-release && \
  # Install systemd && \
  zypper --non-interactive install systemd && \
  # Install utilities needed to test Ansible
  zypper --non-interactive install ca-certificates net-tools python3 python3-pip python3-wheel python3-setuptools sudo system-group-wheel && \
  # Strip down systemd
  rm -f /usr/lib/systemd/system/multi-user.target.wants/* && \
  rm -f /etc/systemd/system/*.wants/* && \
  rm -f /usr/lib/systemd/system/local-fs.target.wants/* && \
  rm -f /usr/lib/systemd/system/sockets.target.wants/*udev* && \
  rm -f /usr/lib/systemd/system/sockets.target.wants/*initctl* && \
  rm -f /usr/lib/systemd/system/basic.target.wants/* && \
  rm -f /usr/lib/systemd/system/anaconda.target.wants/* && \
  # Clean (purge) the repo cache
  zypper --non-interactive clean --all

RUN mkdir -p /lib/systemd \
  && ln -s /usr/lib/systemd/systemd /lib/systemd/systemd

RUN /usr/bin/python3 -m pip install -U pip setuptools wheel \
  && /usr/bin/pip3 --version \
  && /usr/bin/pip3 install --no-cache-dir $pip_packages

# Without this, init won't start the enabled services. Starting the services
# fails with one of:
#     Failed to get D-Bus connection: Operation not permitted
#     System has not been booted with systemd as init system (PID 1). Can't operate.
#     Failed to connect to bus: No such file or directory
VOLUME [ "/sys/fs/cgroup", "/run" ]

# Start via systemd
CMD ["/usr/lib/systemd/systemd"]

# Image metadata
LABEL org.label-schema.vendor="Mesaguy" \
      org.label-schema.name="OpenSUSE Linux leap 15.2 boot" \
      org.label-schema.description="Image boots OpenSUSE Linux leap 15.2 via systemd"
