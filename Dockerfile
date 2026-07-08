FROM ghcr.io/ggml-org/llama.cpp:server-cuda

ENV LD_LIBRARY_PATH="/app:$LD_LIBRARY_PATH"
ENV HF_CACHE="/workspace/model"
ARG MODEL_PATH="/workspace/model/ornith-1.0-35b-NVFP4-MTP.gguf"

WORKDIR /workspace

COPY --chmod=755 entrypoint.sh .

RUN mkdir -p /workspace/model && \
    wget --tries=5 --retry-connrefused --timeout=30 -c \
    --progress=dot:giga \
    -O "$MODEL_PATH" \
    "https://huggingface.co/s-batman/Ornith-1.0-35B-NVFP4-MTP-GGUF/resolve/main/ornith-1.0-35b-NVFP4-MTP.gguf"

#RUN /app/llama download --hf-repo s-batman/Ornith-1.0-35B-NVFP4-MTP-GGUF:NVFP4

ENTRYPOINT ["/workspace/entrypoint.sh"]
CMD []
