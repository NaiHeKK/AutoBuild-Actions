#!/bin/bash
# https://github.com/Hyy2001X/AutoBuild-Actions
# AutoBuild Module by Hyy2001
# AutoBuild DiyScript

Diy_Core() {
	Author=NaiHeKK
	Default_Device=

	INCLUDE_AutoUpdate=true
	INCLUDE_AutoBuild_Tools=true
	INCLUDE_DRM_I915=true
}

Diy-Part1() {
	Diy_Part1_Base

	Update_Makefile xray-core package/lean/helloworld/xray-core
	Update_Makefile exfat package/kernel/exfat
}

Diy-Part2() {
	Diy_Part2_Base
	ExtraPackages svn other/../../feeds/packages/admin netdata https://github.com/openwrt/packages/trunk/admin
	ExtraPackages git other openwrt-passwall https://github.com/xiaorouji main

	Replace_File CustomFiles/uhttpd.po feeds/luci/applications/luci-app-uhttpd/po/zh-cn
	Replace_File CustomFiles/webadmin.po package/lean/luci-app-webadmin/po/zh-cn
	Replace_File CustomFiles/mwan3.config package/feeds/packages/mwan3/files/etc/config mwan3

	case ${TARGET_PROFILE} in
	d-team_newifi-d2)
		Replace_File CustomFiles/mac80211.sh package/kernel/mac80211/files/lib/wifi
		Replace_File CustomFiles/system_newifi-d2 package/base-files/files/etc/config system
		Replace_File CustomFiles/102-mt7621-fix-cpu-clk-add-clkdev.patch target/linux/ramips/patches-5.4
	;;
	*)
		Replace_File CustomFiles/system_common package/base-files/files/etc/config system
	;;
	esac
}

Diy-Part3() {
	Diy_Part3_Base
}
