FROM quay.io/pypa/manylinux2014_x86_64 as builder

USER root

RUN curl --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal

COPY . /app/
WORKDIR /app
ENV PATH="${PATH}:/root/.cargo/bin"
RUN cargo build --release

FROM scratch
COPY --from=builder /app/target/release/horust .
ENTRYPOINT [ "./horust" ]
