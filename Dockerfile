FROM alpine:edge
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk add shadowsocks-libev privoxy && \
  echo -e "\
user-manual /usr/share/doc/privoxy/user-manual/\n\
confdir /etc/privoxy\n\
logdir /var/log/privoxy\n\
actionsfile match-all.action # Actions that are applied to all sites and maybe overruled later on.\n\
actionsfile default.action   # Main actions file\n\
actionsfile user.action      # User customizations\n\
filterfile default.filter\n\
filterfile user.filter      # User customizations\n\
logfile privoxy.log\n\
forward-socks5 / 127.0.0.1:1080 .\n\
listen-address  0.0.0.0:8118\n\
toggle  1\n\
enable-remote-toggle  0\n\
enable-remote-http-toggle  0\n\
enable-edit-actions 0\n\
enforce-blocks 0\n\
buffer-limit 4096\n\
enable-proxy-authentication-forwarding 0\n\
forwarded-connect-retries  0\n\
accept-intercepted-requests 0\n\
allow-cgi-request-crunching 0\n\
split-large-forms 0\n\
keep-alive-timeout 5\n\
tolerate-pipelining 1\n\
socket-timeout 300\n\
" > /etc/privoxy/config && \
  echo -e "#!/bin/sh\n\
su -s /bin/sh privoxy /usr/sbin/privoxy /etc/privoxy/config\n\
exec /usr/bin/ss-local -a nobody -l 1080 \"\$@\"\n\
" > /docker-entrypoint.sh && \
chmod +x /docker-entrypoint.sh

EXPOSE 1080
EXPOSE 8118
ENTRYPOINT ["/docker-entrypoint.sh"]
