FROM ghcr.io/ggml-org/llama.cpp:server-cuda

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

ENV LD_LIBRARY_PATH="/app:$LD_LIBRARY_PATH"
ENV HF_HUB_CACHE="/workspace/model"

WORKDIR /workspace

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir --break-system-packages -U "huggingface_hub"
RUN --mount=type=secret,id=hf_token,env=HF_TOKEN \
    hf download s-batman/Ornith-1.0-35B-NVFP4-MTP-GGUF ornith-1.0-35b-NVFP4-MTP.gguf

COPY --chmod=755 entrypoint.sh .

ENTRYPOINT ["/workspace/entrypoint.sh"]
CMD []
