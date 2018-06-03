#!/bin/bash
rm -rf docs
gatsby build --prefix-paths
mv public docs
