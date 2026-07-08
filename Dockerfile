FROM ghcr.io/ggml-org/llama.cpp:server-cuda

ENV LD_LIBRARY_PATH="/app:$LD_LIBRARY_PATH"
ENV HF_CACHE="/workspace/model"

WORKDIR /workspace

COPY --chmod=755 entrypoint.sh .
RUN /app/llama download --hf-repo s-batman/Ornith-1.0-35B-NVFP4-MTP-GGUF:NVFP4

ENTRYPOINT ["/workspace/entrypoint.sh"]
CMD []
