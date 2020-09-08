FROM keppel.eu-de-1.cloud.sap/ccloud/golang-builder as builder

ADD .   /go/src/github.com/justwatchcom/sql_exporter
WORKDIR /go/src/github.com/justwatchcom/sql_exporter

RUN make

FROM        quay.io/prometheus/busybox:glibc
MAINTAINER  The Prometheus Authors <prometheus-developers@googlegroups.com>
LABEL source_repository="https://github.com/sapcc/sql_exporter"

COPY --from=builder /go/src/github.com/justwatchcom/sql_exporter/sql_exporter  /bin/sql_exporter

EXPOSE      9237
ENTRYPOINT  [ "/bin/sql_exporter" ]
