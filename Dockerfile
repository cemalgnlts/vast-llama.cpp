FROM ghcr.io/ggml-org/llama.cpp:server-cuda

ENV LD_LIBRARY_PATH="/app:$LD_LIBRARY_PATH"
ENV HF_CACHE="/workspace/model"
ARG MODEL_PATH="/workspace/model/ornith-1.0-35b-NVFP4-MTP.gguf"

WORKDIR /workspace

COPY --chmod=755 entrypoint.sh .
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install --no-cache-dir --break-system-packages "huggingface_hub[hf_xet]" && \
    mkdir -p /workspace/model && \
    hf download s-batman/Ornith-1.0-35B-NVFP4-MTP-GGUF \
        ornith-1.0-35b-NVFP4-MTP.gguf \
        --local-dir /workspace/model

#RUN /app/llama download --hf-repo s-batman/Ornith-1.0-35B-NVFP4-MTP-GGUF:NVFP4

ENTRYPOINT ["/workspace/entrypoint.sh"]
CMD []
