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

# Прямая модификация кода ядра для принудительного разгона ЦП до 1100 МГц
sed -i '/static void __init mt7621_clk_init/a \
\v\vo\vi\vd\ \*\m\me\mm\mc\ \=\ \i\oo\re\mm\aa\p\(\0\xi\1\ee\0\0\7\0\0\0\,\ \0\xi\1\0\0\0\)\;\ \i\ff\ \(\mm\ee\mm\cc\)\ \{\ \w\ri\tt\ee\ll\(\(\re\aa\dd\ll\(\mm\ee\mm\cc\ \+\ \0\xi\6\4\8\)\ \&\ \~\(\0\xi\7\ff\ \<\<\ \4\)\)\ \|\ \(\0\xi\2\bb\ \<\<\ \4\)\,\ \mm\ee\mm\cc\ \+\ \0\xi\6\4\8\)\;\ \i\oo\un\mm\aa\p\(\mm\ee\mm\cc\)\;\ \}' target/linux/ramips/files-6.6/drivers/clk/ralink/clk-mt7621.c || sed -i '/static void __init mt7621_clk_init/a \    void __iomem *memc = ioremap(0x1e007000, 0x1000); if (memc) { writel((readl(memc + 0x648) & ~(0x7f << 4)) | (0x2b << 4), memc + 0x648); iounmap(memc); }' target/linux/ramips/files-6.1/drivers/clk/ralink/clk-mt7621.c

# Исправляем DTS роутера для корректного расчета таймеров на 1100 МГц
sed -i 's/clock-frequency = <880000000>;/clock-frequency = <1100000000>;/g' target/linux/ramips/dts/mt7621_xiaomi_mi-router-3g.dts
