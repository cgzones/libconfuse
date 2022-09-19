#!/bin/sh

set -eu

#SAN_FLAGS='-O1 -g -ftrivial-auto-var-init=pattern -fsanitize=address -fsanitize-address-use-after-scope -fsanitize-address-use-after-return=always -fno-omit-frame-pointer -fsanitize=undefined -fsanitize=nullability -fsanitize=implicit-conversion -fsanitize=integer -fsanitize=float-divide-by-zero -fsanitize=local-bounds'

#SAN_FLAGS='-O1 -g -fsanitize=undefined'
#SAN_FLAGS='-O1 -g -fsanitize=memory -fsanitize-memory-track-origins=2 -fno-omit-frame-pointer'
#SAN_FLAGS='-O1 -g -Wall -Wextra'
SAN_FLAGS='-Wall -Wcast-align -Wcast-qual -Wextra -Wfloat-equal -Wformat=2 -Winit-self -Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-dereference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Wwrite-strings -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2'

make distclean || true

./configure CC='ccache clang-15' CFLAGS="-Wall -Wextra $SAN_FLAGS" LDFLAGS="$SAN_FLAGS"

make clean

make -j$(nroc)

make check -j$(nproc)
