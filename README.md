# docker-shadowsocks-client

```
docker build -t ss .
docker run -it --rm -p 1080:1080 -p 8118:8118 ss -s 服务器地址 -p 端口 -k 密码 -m 加密方式
```

1080是socks5代理，8118是http代理。
