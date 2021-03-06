#!/bin/bash

# Author: Jason Lewis <jason@decomplecting.org>

# Usage: bin/stub.sh {exercise-name}
# Creates the directory, stub exercise file, and test file.

# Front material here... subject to change. Would be nice
# to work some sed/awk-jitsu to update old tests when things
# change, but for now, KISS.

# Assumes the module, exercise, and test names are the same; this
# is not always the case (see, for instance, the rna-transcription
# exercise). Normalizing names has been discussed in this PR:
# https://github.com/exercism/xscheme/pull/17
# For now, adding warning about name conventions.


testhead=";; Load SRFI-64 lightweight testing specification\n
(use-modules (srfi srfi-64))\n
\n
;; Suppress log file output. To write logs, comment out the following line:\n
(module-define! (resolve-module '(srfi srfi-64)) 'test-log-to-file #f)\n
\n
;; Require module\n
(add-to-load-path (dirname (current-filename)))\n
(use-modules ($1))\n
\n
(test-begin \"$1\")\n
\n
;; Tests go here\n
\n
(test-end \"$1\")";

stubhead="(define-module ($1)\n
;;Be sure to define your exports with #:export (fns)\n)";

# Create the exercise directory
mkdir -p "$1"

# Write the stub files
if [[ -d $1 ]]
then
    echo -e $testhead > "$1/$1-test.scm"
    echo -e $stubhead > "$1/$1.scm"
    echo -e "Generated files assume normalized naming, adjust as needed."
    exit 0
else
    echo "An error occurred; is $1 a dir in the cwd?"
    exit 1
fi
