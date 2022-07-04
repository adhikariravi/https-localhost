#!/bin/sh
openssl req \
    -x509 \
    -nodes \
    -new -sha256 -days 1024 \
    -newkey rsa:2048 \
    -keyout CA.key \
    -out CA.pem \
    -subj "/C=NP/CN=RAWV-CA"
openssl x509 \
    -outform pem \
    -in CA.pem \
    -out CA.crt
openssl req \
    -new -nodes \
    -newkey rsa:2048 \
    -keyout App.key \
    -out App.csr \
    -subj "/C=NP/ST=RAWV/L=RAWV/O=RAWV-Pvt-Ltd/CN=rawv.io"
openssl x509 -req -sha256 \
    -in App.csr \
    -CA CA.pem \
    -CAkey CA.key \
    -CAcreateserial \
    -extfile domains.ext \
    -out App.crt
