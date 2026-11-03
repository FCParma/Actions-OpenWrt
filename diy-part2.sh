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

# Создаем патч разгона процессора до 1100 МГц
mkdir -p target/linux/ramips/patches-6.6/
cat << 'EOF' > target/linux/ramips/patches-6.6/999-mt7621-overclock-1100mhz.patch
--- a/drivers/clk/ralink/clk-mt7621.c
+++ b/drivers/clk/ralink/clk-mt7621.c
@@ -145,6 +145,14 @@ static void __init mt7621_clk_init(struc
 	u32 val;
 	int i;
 
+	/* Принудительный разгон CPU до 1100 MHz */
+	void __iomem *memc = ioremap(0x1e007000, 0x1000);
+	if (memc) {
+		writel((readl(memc + 0x648) & ~(0x7f << 4)) | (0x2b << 4), memc + 0x648);
+		iounmap(memc);
+	}
+
 	sysc = ioremap(SYSC_BASE, SZ_4K);
 	if (!sysc)
 		return;
EOF

# Исправляем DTS роутера для корректного расчета таймеров на 1100 МГц
sed -i 's/clock-frequency = <880000000>;/clock-frequency = <1100000000>;/g' target/linux/ramips/dts/mt7621_xiaomi_mi-router-3g.dts
