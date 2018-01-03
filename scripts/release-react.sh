#!/bin/bash

set -e

cd packages

middlewares=(
  graphql-playground-middleware-express
  # graphql-playground-middleware-hapi
  # graphql-playground-middleware-koa
  # graphql-playground-middleware-lambda
)

cd graphql-playground-html
echo "Releasing graphql-playground-react..."
npm version patch --no-git-tag-version
npm publish
cd ..

for middleware in "${middlewares[@]}"
do
  cd $middleware
  echo "Releasing ${middleware}..."
  yarn add graphql-playground-react
  npm version patch --no-git-tag-version
  npm publish
  cd ..
done