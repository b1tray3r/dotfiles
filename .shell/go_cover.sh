#!/bin/bash

function cover() {
	go test -coverprofile /var/tmp/cover.out . && go tool cover -html=/var/tmp/cover.out -o /var/tmp/cover.html
}

function cover_watch() {
	watch -n 5 "go test -coverprofile /var/tmp/cover.out . && go tool cover -html=/var/tmp/cover.out -o /var/tmp/cover.html"
}
