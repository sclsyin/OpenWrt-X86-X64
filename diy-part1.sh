# !/bin/bash
# 
#  Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
# 
#  This is free software, licensed under the MIT License.
#  See /LICENSE for more information.
# 
#  https://github.com/P3TERX/Actions-OpenWrt
#  File name: diy-part1.sh
#  Description: OpenWrt DIY script part 1 (Before Update feeds)
# 

#  Uncomment a feed source
# sed -i 's/^# \(.*helloworld\)/\1/' feeds.conf.default

#  Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
# sudo apt-get -y install build-essential asciidoc binutils bzip2 curl gawk gettext git libncurses5-dev libz-dev patch python3.5 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf gper

mkdir -p turboacc_tmp ./package/turboacc
cd turboacc_tmp 
git clone https://github.com/chenmozhijin/turboacc -b package
cd ../package/turboacc
git clone https://github.com/fullcone-nat-nftables/nft-fullcone
git clone https://github.com/chenmozhijin/turboacc
mv ./turboacc/luci-app-turboacc ./luci-app-turboacc
rm -rf ./turboacc
cd ../..
cp -f turboacc_tmp/turboacc/hack-5.10/952-net-conntrack-events-support-multiple-registrant.patch ./target/linux/generic/hack-5.10/952-net-conntrack-events-support-multiple-registrant.patch
cp -f turboacc_tmp/turboacc/hack-5.10/953-net-patch-linux-kernel-to-support-shortcut-fe.patch ./target/linux/generic/hack-5.10/953-net-patch-linux-kernel-to-support-shortcut-fe.patch
cp -f turboacc_tmp/turboacc/pending-5.10/613-netfilter_optional_tcp_window_check.patch ./target/linux/generic/hack-5.10/613-netfilter_optional_tcp_window_check.patch
rm -rf ./package/libs/libnftnl ./package/network/config/firewall4 ./package/network/utils/nftables
mkdir -p ./package/network/config/firewall4 ./package/libs/libnftnl ./package/network/utils/nftables
cp -r ./turboacc_tmp/turboacc/shortcut-fe ./package/turboacc
cp -RT ./turboacc_tmp/turboacc/firewall4-04a06bd70b9808b14444cae81a2faba4708ee231/firewall4 ./package/network/config/firewall4
cp -RT ./turboacc_tmp/turboacc/libnftnl-1.2.5/libnftnl ./package/libs/libnftnl
cp -RT ./turboacc_tmp/turboacc/nftables-1.0.7/nftables ./package/network/utils/nftables
rm -rf turboacc_tmp
echo "#   CONFIG_NF_CONNTRACK_CHAIN_EVENTS is not set" >> target/linux/generic/config-5.10
echo "#   CONFIG_SHORTCUT_FE is not set" >> target/linux/generic/config-5.10
