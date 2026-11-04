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

# Создаем целевую папку для патчей самого нового ядра 6.18
mkdir -p target/linux/ramips/patches-6.18/

# Записываем точный патч разгона для драйвера clk-mt7621.c
cat << 'EOF' > target/linux/ramips/patches-6.18/999-mt7621-overclock-1100mhz.patch
--- a/drivers/clk/ralink/clk-mt7621.c
+++ b/drivers/clk/ralink/clk-mt7621.c
@@ -536,6 +536,12 @@ static void __init mt7621_clk_init(struc
 	if (IS_ERR(priv->memc)) {
 		pr_err("Could not get memc syscon regmap\n");
 		goto free_clk_priv;
+	}
+
+	/* Принудительный разгон до 1100 МГц на этапе инициализации часов */
+	if (!regmap_update_bits(priv->memc, MEMC_REG_CPU_PLL, (0x7f << 4), (0x2b << 4))) {
+		pr_info("MT7621 Overclock: Register 0x648 updated to 1100 MHz\n");
 	}
 
 	count = ARRAY_SIZE(mt7621_clks_base) +
EOF
