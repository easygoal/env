#!/bin/bash

# find each unique line and print it out
awk '!($0 in a) {a[$0];print}'
