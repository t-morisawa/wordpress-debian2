FROM debian:9.5

RUN apt-get update && apt-get -y upgrade && apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev
RUN apt-get -y install openssh-server ufw curl vim less sudo python
RUN mkdir /var/run/sshd

RUN useradd -m testuser && echo "testuser:testuser" | chpasswd && gpasswd -a testuser sudo
RUN mkdir -p /home/testuser/.ssh; chown testuser /home/testuser/.ssh; chmod 700 /home/testuser/.ssh
 
ADD ./authorized_keys /home/testuser/.ssh/authorized_keys
RUN chown testuser /home/testuser/.ssh/authorized_keys; chmod 600 /home/testuser/.ssh/authorized_keys

CMD /usr/sbin/sshd -D && tail -f /dev/null
