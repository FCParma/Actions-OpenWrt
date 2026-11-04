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

# Создаем целевую папку для патчей ядра 6.12
mkdir -p target/linux/ramips/patches-6.12/

# Записываем точечный патч для файла arch/mips/ralink/mt7621.c
cat << 'EOF' > target/linux/ramips/patches-6.12/999-mt7621-early-overclock-1100mhz.patch
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -217,4 +217,6 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 	if (!register_vsmp_smp_ops())
 		return;
+
+	*(volatile uint32_t *)(0xbe007648) = (*(volatile uint32_t *)(0xbe007648) & ~(0x7f << 4)) | (0x2b << 4);
 }
 EOF
