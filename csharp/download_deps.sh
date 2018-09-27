#!/usr/bin/env bash

set -e -x

cd "$(dirname "$0")"

BUILD_DIR="$(pwd)"
DOWNLOAD_DIR="${BUILD_DIR}/deps"
SDK_VERSION="13.3.0"
mkdir -p "${DOWNLOAD_DIR}"

# Get the tools
# * Spatial Schema compiler
# * Standard Library Schemas
# * Core SDK for all platforms to enable building workers for MacOS, Windows or Linux
# * C# SDK
# if [ ! -f "${DOWNLOAD_DIR}/schema_compiler-x86_64-${PLATFORM_NAME}.zip" ]; then
#   spatial package retrieve --force tools "schema_compiler-x86_64-${PLATFORM_NAME}" "${SDK_VERSION}" "${DOWNLOAD_DIR}/schema_compiler-x86_64-${PLATFORM_NAME}.zip"
# fi
# if [ ! -f "$DOWNLOAD_DIR/standard_library.zip" ]; then
#   spatial package retrieve --force schema standard_library "${SDK_VERSION}" "$DOWNLOAD_DIR/standard_library.zip"
# fi
if [ ! -f "$DOWNLOAD_DIR/csharp.zip" ]; then
  spatial package retrieve --force worker_sdk csharp "${SDK_VERSION}" "$DOWNLOAD_DIR/csharp.zip"
fi
if [ ! -f "${DOWNLOAD_DIR}/core-dynamic-x86_64-win32.zip" ]; then
  spatial package retrieve --force worker_sdk core-dynamic-x86_64-win32 "${SDK_VERSION}" "${DOWNLOAD_DIR}/core-dynamic-x86_64-win32.zip"
fi
if [ ! -f "${DOWNLOAD_DIR}/core-dynamic-x86_64-linux.zip" ]; then
  spatial package retrieve --force worker_sdk core-dynamic-x86_64-linux "${SDK_VERSION}" "${DOWNLOAD_DIR}/core-dynamic-x86_64-linux.zip"
fi
if [ ! -f "${DOWNLOAD_DIR}/core-dynamic-x86_64-macos.zip" ]; then
  spatial package retrieve --force worker_sdk core-dynamic-x86_64-macos "${SDK_VERSION}" "${DOWNLOAD_DIR}/core-dynamic-x86_64-macos.zip"
fi

pushd "$DOWNLOAD_DIR"
unzip -o "${DOWNLOAD_DIR}/csharp.zip"
unzip -o "${DOWNLOAD_DIR}/core-dynamic-x86_64-win32.zip"
unzip -o "${DOWNLOAD_DIR}/core-dynamic-x86_64-linux.zip"
unzip -o "${DOWNLOAD_DIR}/core-dynamic-x86_64-macos.zip"
popd
echo "WorkerSDK dependencies downloaded"