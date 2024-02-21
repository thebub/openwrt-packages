#
# Copyright (C) 2006-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dsa-fixfdb
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_MAINTAINER:=Daniel Bub <bub@thebub.net>

PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/dsa-fixfdb/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Helpers
  PKGARCH:=all
endef

define Package/dsa-fixfdb
$(call Package/dsa-fixfdb/Default)
  TITLE:=DSA-FDB Correction Service
  DEPENDS:=+ip-bridge
endef

define Package/dsa-fixfdb/description
	DSA-fixfdb is a simple script to correct erroneous roaming-entries in the FDB
	table, caused by a bug in the DSA system. (See https://github.com/openwrt/openwrt/issues/11650)
endef

define Package/dsa-fixfdb/conffiles
/etc/config/fixfdb
endef

define Package/dsa-fixfdb/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/fixfdb.config $(1)/etc/config/fixfdb
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/fixfdb.init $(1)/etc/init.d/fixfdb
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/fixfdb.sh $(1)/usr/bin/fixfdb
endef

$(eval $(call BuildPackage,dsa-fixfdb))
