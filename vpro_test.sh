#!/bin/bash
SET=$(seq 1 255)
for i in $SET
do
	amttool 192.168.6.$i info
done
