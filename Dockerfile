FROM ghcr.io/ggml-org/llama.cpp:server-cuda

ENV LD_LIBRARY_PATH="/app:$LD_LIBRARY_PATH"

WORKDIR /workspace

COPY entrypoint.sh .

ENTRYPOINT ["/workspace/entrypoint.sh"]
CMD []