#!/bin/csh

set SECRET=`echo 'xxxxxxxx' | base64 -d`
set USER_NAME = `whoami`
set HOST_NAME = hostname

cd ${HOME}

if !(-e ~/.ssh/id_rsa.pub) then 
	ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa -q
endif

ssh-copy-id.expect ${USER_NAME} ${HOST_NAME} ${SECRET}

