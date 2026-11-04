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

# Принудительная инициализация регистра CPU PLL на частоту 1100 МГц (early setup)
mkdir -p target/linux/ramips/patches-6.6/
echo -e '--- a/arch/mips/ralink/mt7621.c\n+++ b/arch/mips/ralink/mt7621.c\n@@ -200,4 +200,6 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)\n \t\t\tsoc_info->mem_size = MT7621_MAX_MEM;\n \t}\n+\n+\t*(volatile uint32_t *)(0xbe007648) = (*(volatile uint32_t *)(0xbe007648) & ~(0x7f << 4)) | (0x2b << 4);\n }' > target/linux/ramips/patches-6.6/999-mt7621-early-overclock-1100mhz.patch
