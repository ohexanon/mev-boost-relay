# syntax=docker/dockerfile:1
FROM public.ecr.aws/q0m5j4m5/golang:latest as builder
ARG VERSION
WORKDIR /build
ADD . /build/
RUN CGO_CFLAGS="-O -D__BLST_PORTABLE__" CGO_CFLAGS_ALLOW="-O -D__BLST_PORTABLE__" go build -v -o boost-relay .

# FROM alpine
# RUN apk add --no-cache libstdc++ libc6-compat
# WORKDIR /app
# COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
FROM scratch AS export-stage
COPY --from=builder /build/boost-relay /application
# ENTRYPOINT ["/app/boost-relay"]
