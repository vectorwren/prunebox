#!/bin/bash
set -e

VERSION=$1
if [ -z "$VERSION" ]; then
  echo "Usage: ./scripts/build-release.sh <version>"
  echo "Example: ./scripts/build-release.sh v1.0.0"
  exit 1
fi

# Login to GitHub Container Registry
echo "Logging in to GitHub Container Registry..."
echo "${GITHUB_TOKEN:?set GITHUB_TOKEN}" | docker login ghcr.io -u vectorwren --password-stdin

echo "Building Prunebox Release $VERSION..."

# Build image for GitHub Container Registry
docker build -t ghcr.io/vectorwren/prunebox:$VERSION -t ghcr.io/vectorwren/prunebox:latest .

echo "✅ Built image:"
echo "  - ghcr.io/vectorwren/prunebox:$VERSION"
echo ""
echo "Pushing to GitHub Container Registry..."
docker push ghcr.io/vectorwren/prunebox:$VERSION
docker push ghcr.io/vectorwren/prunebox:latest

echo "✅ Release $VERSION pushed successfully!"
