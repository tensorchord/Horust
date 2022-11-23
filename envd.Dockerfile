FROM quay.io/pypa/manylinux2010_x86_64 as builder

RUN curl --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal

COPY . /app/
WORKDIR /app
RUN cargo build --release

FROM scratch
COPY --from=builder /app/target/release/horust .
ENTRYPOINT [ "./horust" ]
