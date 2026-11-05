#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# Гарантированный разгон MT7621 через переопределение системной частоты в DTS процессора
sed -i 's/clock-frequency = <880000000>;/clock-frequency = <1100000000>;/g' target/linux/ramips/dts/mt7621.dtsi
sed -i 's/clock-frequency = <220000000>;/clock-frequency = <275000000>;/g' target/linux/ramips/dts/mt7621.dtsi
