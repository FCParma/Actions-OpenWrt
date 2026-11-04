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

# Модифицируем исходный файл драйвера часов до сборки ядра
# Находим строку "if (IS_ERR(priv->memc)) {" и сразу после закрывающей скобки блока if (строка 539) вставляем код разгона регистров
sed -i '/if (IS_ERR(priv->memc)) {/,/}/!b; /}/a \\n\t/* Forced Overclock to 1100 MHz */\n\tregmap_update_bits(priv->memc, MEMC_REG_CPU_PLL, (0x7f << 4), (0x2b << 4));' target/linux/ramips/patches-6.12/102-mt7621-clk-driver.patch || sed -i '/if (IS_ERR(priv->memc)) {/,/}/!b; /}/a \\n\t/* Forced Overclock to 1100 MHz */\n\tregmap_update_bits(priv->memc, MEMC_REG_CPU_PLL, (0x7f << 4), (0x2b << 4));' target/linux/ramips/patches-*/102-mt7621-clk-driver.patch
