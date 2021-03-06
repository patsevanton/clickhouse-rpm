#!/bin/bash

list_dependencies=(rpm-build rpmdevtools make epel-release centos-release-scl)

for i in ${list_dependencies[*]}
do
    if ! rpm -qa | grep -qw $i; then
        echo "__________Dont installed '$i'__________"
        #yum -y install $i
    fi
done

rm -rf ~/rpmbuild/
mkdir -p ~/rpmbuild/{RPMS,SRPMS,BUILD,SOURCES,SPECS}
cp SOURCES/* ~/rpmbuild/SOURCES
spectool -g -R SPECS/clickhouse.spec
rpmbuild -bb SPECS/clickhouse.spec
