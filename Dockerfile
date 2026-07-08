FROM ghcr.io/ggml-org/llama.cpp:server-cuda

ENV LD_LIBRARY_PATH="/app:$LD_LIBRARY_PATH"
ENV HF_CACHE="/workspace/model"
ARG MODEL_PATH="/workspace/model/ornith-1.0-35b-NVFP4-MTP.gguf"

WORKDIR /workspace

COPY --chmod=755 entrypoint.sh .
RUN mkdir -p /workspace/model && \
    apt-get update && \
    apt-get install -y --no-install-recommends aria2 ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    aria2c -x16 -s16 -c --max-tries=5 --retry-wait=5 \
    -d /workspace/model -o ornith-1.0-35b-NVFP4-MTP.gguf \
    "https://huggingface.co/s-batman/Ornith-1.0-35B-NVFP4-MTP-GGUF/resolve/main/ornith-1.0-35b-NVFP4-MTP.gguf"

#RUN /app/llama download --hf-repo s-batman/Ornith-1.0-35B-NVFP4-MTP-GGUF:NVFP4

ENTRYPOINT ["/workspace/entrypoint.sh"]
CMD []
