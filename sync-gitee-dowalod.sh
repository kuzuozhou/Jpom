#!/bin/bash

DIR_PATH=$(cd `dirname $0`; pwd)""

echo ${DIR_PATH}


Mirror_Host=github.com
# Mirror_Host=download.fastgit.org
#Mirror_Host=hub.fastgit.xyz

function downloadItem()
{
echo "https://${Mirror_Host}/dromara/Jpom/releases/download/v$3/$1-$3-release.$2.sha1"
mkdir -p ${DIR_PATH}/temp-github/$3
curl -LfsSo ${DIR_PATH}/temp-github/$3/$1-$3-release.$2.sha1 https://${Mirror_Host}/dromara/Jpom/releases/download/v$3/$1-$3-release.$2.sha1

curl -LfsSo ${DIR_PATH}/temp-github/$3/$1-$3-release.$2 https://${Mirror_Host}/dromara/Jpom/releases/download/v$3/$1-$3-release.$2
}

function download28(){
i=16
while((i<=25))
do
	echo "downloadItem agent tar.gz 2.8.$i"
	downloadItem agent tar.gz 2.8.$i
	echo "downloadItem agent zip 2.8.$i"
    downloadItem agent zip 2.8.$i
	#
	echo "downloadItem server tar.gz 2.8.$i"
    downloadItem server tar.gz 2.8.$i
    echo "downloadItem server zip 2.8.$i"
	downloadItem server zip 2.8.$i
	((i++))
done
}

function download29(){
i=1
while((i<=6))
do
	echo "downloadItem agent tar.gz 2.9.$i"
	downloadItem agent tar.gz 2.9.$i
	echo "downloadItem agent zip 2.9.$i"
    downloadItem agent zip 2.9.$i
	#
	echo "downloadItem server tar.gz 2.9.$i"
    downloadItem server tar.gz 2.9.$i
    echo "downloadItem server zip 2.9.$i"
	downloadItem server zip 2.9.$i
	((i++))
done
}

function checkSha1sum(){
i=16
while((i<=25))
do

	checkSha1sumItem agent tar.gz 2.8.$i

    checkSha1sumItem agent zip 2.8.$i
	#

    checkSha1sumItem server tar.gz 2.8.$i

	checkSha1sumItem server zip 2.8.$i
	((i++))
done

i=1
while((i<=6))
do

	checkSha1sumItem agent tar.gz 2.9.$i

    checkSha1sumItem agent zip 2.9.$i
	#

    checkSha1sumItem server tar.gz 2.9.$i

	checkSha1sumItem server zip 2.9.$i
	((i++))
done

}


function checkSha1sumItem()
{

ESUM=`cat ${DIR_PATH}/temp-github/$3/$1-$3-release.$2.sha1`

echo "${ESUM} ${DIR_PATH}/temp-github/$3/$1-$3-release.$2" | sha1sum -c -;
}


function checkZip(){
i=16
while((i<=25))
do
zip -rj ${DIR_PATH}/temp-github/2.8.$i/jpom-2.8.$i.zip ${DIR_PATH}/temp-github/2.8.$i/server-2.8.$i-release.zip ${DIR_PATH}/temp-github/2.8.$i/agent-2.8.$i-release.zip
	((i++))
done

i=1
while((i<=6))
do

	zip -rj ${DIR_PATH}/temp-github/2.9.$i/jpom-2.9.$i.zip ${DIR_PATH}/temp-github/2.9.$i/server-2.9.$i-release.zip ${DIR_PATH}/temp-github/2.9.$i/agent-2.9.$i-release.zip
	((i++))
done

}

# download28
# download29
# checkSha1sum
# checkZip


ossutilmac64 sync ${DIR_PATH}/temp-github/ oss://jpom-releases/release/ --delete -f