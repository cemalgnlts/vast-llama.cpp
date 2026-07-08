FROM ghcr.io/ggml-org/llama.cpp:server-cuda

ENV LD_LIBRARY_PATH="/app:$LD_LIBRARY_PATH"
ENV HF_CACHE="/workspace/model"
ARG MODEL_PATH="/workspace/model/ornith-1.0-35b-NVFP4-MTP.gguf"

WORKDIR /workspace

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir --break-system-packages "huggingface_hub[hf_xet]"
RUN --mount=type=secret,id=hf_token,env=HF_TOKEN \
    mkdir -p /workspace/model && \
    hf download s-batman/Ornith-1.0-35B-NVFP4-MTP-GGUF --local-dir /workspace/model

COPY --chmod=755 entrypoint.sh .

ENTRYPOINT ["/workspace/entrypoint.sh"]
CMD []
