#!/bin/bash -uex

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

if [ -d xmr-stak ]; then
  git -C xmr-stak clean -fd
else
  git clone https://github.com/fireice-uk/xmr-stak.git
fi


# ########################
# # Ubuntu (18.04)
# ########################
# docker run --rm -it -v $PWD:/mnt ubuntu:18.04 /bin/bash -c "
# set -x ;
# apt update -qq ;
# apt install -y -qq libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev ;
# cd /mnt/xmr-stak ;
# /mnt/cuda_*_linux-run --silent --toolkit ;
# cmake -DCUDA_ENABLE=ON -DOpenCL_ENABLE=OFF . ;
# make ;
# "

########################
# Ubuntu (18.04)
########################
docker run -itd --name "xmr" -v $PWD:/mnt ubuntu:18.04 /bin/bash
docker exec -it "xmr" /bin/bash -c "
set -x ;
apt update -qq
apt install -y -qq libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev ;
cd /mnt/xmr-stak ;
cmake -DCUDA_ENABLE=OFF -DOpenCL_ENABLE=OFF . ;
make install;
"
