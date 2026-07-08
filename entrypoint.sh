#!/bin/bash

cd /workspace

/app/llama-server \
  --top-k "${LLAMA_ARG_TOP_K:-40}" \
  --top-p "${LLAMA_ARG_TOP_P:-0.95}" \
  --min-p "${LLAMA_ARG_MIN_P:-0.05}" \
  --temp "${LLAMA_ARG_TEMP:-0.80}" \
  --reasoning-budget-message "I have thought enough. Let me give my answer now." \
  --gpu-layers "${LLAMA_ARG_N_GPU_LAYERS:-all}" \
  --reasoning-budget 2048 \
  --cache-reuse 256 \
  --flash-attn on \
  --kv-unified \
  --parallel 4 \
  --no-warmup \
  --no-mmproj \
  --no-slots \
  --no-ui &> "$MODEL_LOG"
