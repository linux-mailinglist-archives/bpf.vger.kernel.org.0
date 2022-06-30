Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97B15617D1
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 12:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiF3KYM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 06:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiF3KXz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 06:23:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08EB45069;
        Thu, 30 Jun 2022 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656584602; x=1688120602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W98/29S3vGtkTUYi9YUhxB8rnjYs85jHFm3yLWkMum8=;
  b=QhGFAEH2mH3BhZMyLz68x+y3fU8gGkxzdtWSBryhG8O1m9c+fcrq69j6
   vXTSd/bAx3A26h+PFxZo6FNnJl2HQd3TtXocM9Jzp4ATKAYMEzemXFMyZ
   tOEgdvjz5YlkoUoNC29w56qA6zR9Jkr4UEjVelxO5bjqprGJ5o7FhEbEI
   yUGywIDp6j2HMleYN3G562fFnzy1ZVfzqMXIJq1kBey1XbK3N7Zq1oJpr
   XIuvLTREsUzuH36I/VuXtg2EZ7GI2eQdoB6zhKYD7rYBvU2lw4anx3BwL
   /mhXP0/8R+jwcvtIops09vY17XqH1nyQIp0/FSBgIBpIrjCxdug/9ZTcr
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="170507699"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 03:23:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 03:23:19 -0700
Received: from CHE-LT-I17769U.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 30 Jun 2022 03:23:10 -0700
From:   Arun Ramadoss <arun.ramadoss@microchip.com>
To:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     Woojung Huh <woojung.huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        "Song Liu" <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [Patch net-next v14 11/13] net: dsa: microchip: lan937x: add phylink_mac_link_up support
Date:   Thu, 30 Jun 2022 15:50:39 +0530
Message-ID: <20220630102041.25555-12-arun.ramadoss@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220630102041.25555-1-arun.ramadoss@microchip.com>
References: <20220630102041.25555-1-arun.ramadoss@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch add support for phylink_mac_link_up. It configures the mac
for the speed, flow control and duplex mode.

Signed-off-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
 drivers/net/dsa/microchip/ksz_common.c   | 16 ++++++
 drivers/net/dsa/microchip/ksz_common.h   |  5 ++
 drivers/net/dsa/microchip/lan937x.h      |  4 ++
 drivers/net/dsa/microchip/lan937x_main.c | 67 ++++++++++++++++++++++++
 drivers/net/dsa/microchip/lan937x_reg.h  | 11 ++++
 5 files changed, 103 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index ca7ca327285d..9972b2fabf27 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -221,6 +221,7 @@ static const struct ksz_dev_ops lan937x_dev_ops = {
 	.mirror_add = ksz9477_port_mirror_add,
 	.mirror_del = ksz9477_port_mirror_del,
 	.get_caps = lan937x_phylink_get_caps,
+	.phylink_mac_link_up = lan937x_phylink_mac_link_up,
 	.fdb_dump = ksz9477_fdb_dump,
 	.fdb_add = ksz9477_fdb_add,
 	.fdb_del = ksz9477_fdb_del,
@@ -1340,6 +1341,20 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
 	return dev->dev_ops->max_mtu(dev, port);
 }
 
+static void ksz_phylink_mac_link_up(struct dsa_switch *ds, int port,
+				    unsigned int mode,
+				    phy_interface_t interface,
+				    struct phy_device *phydev, int speed,
+				    int duplex, bool tx_pause, bool rx_pause)
+{
+	struct ksz_device *dev = ds->priv;
+
+	if (dev->dev_ops->phylink_mac_link_up)
+		dev->dev_ops->phylink_mac_link_up(dev, port, mode, interface,
+						  phydev, speed, duplex,
+						  tx_pause, rx_pause);
+}
+
 static int ksz_switch_detect(struct ksz_device *dev)
 {
 	u8 id1, id2;
@@ -1413,6 +1428,7 @@ static const struct dsa_switch_ops ksz_switch_ops = {
 	.phy_read		= ksz_phy_read16,
 	.phy_write		= ksz_phy_write16,
 	.phylink_get_caps	= ksz_phylink_get_caps,
+	.phylink_mac_link_up	= ksz_phylink_mac_link_up,
 	.phylink_mac_link_down	= ksz_mac_link_down,
 	.port_enable		= ksz_enable_port,
 	.get_strings		= ksz_get_strings,
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index bf4f3f3922a5..f449feab5499 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -271,6 +271,11 @@ struct ksz_dev_ops {
 	int (*max_mtu)(struct ksz_device *dev, int port);
 	void (*freeze_mib)(struct ksz_device *dev, int port, bool freeze);
 	void (*port_init_cnt)(struct ksz_device *dev, int port);
+	void (*phylink_mac_link_up)(struct ksz_device *dev, int port,
+				    unsigned int mode,
+				    phy_interface_t interface,
+				    struct phy_device *phydev, int speed,
+				    int duplex, bool tx_pause, bool rx_pause);
 	void (*config_cpu_port)(struct dsa_switch *ds);
 	int (*enable_stp_addr)(struct ksz_device *dev);
 	int (*reset)(struct ksz_device *dev);
diff --git a/drivers/net/dsa/microchip/lan937x.h b/drivers/net/dsa/microchip/lan937x.h
index d4207e97a130..145770aec963 100644
--- a/drivers/net/dsa/microchip/lan937x.h
+++ b/drivers/net/dsa/microchip/lan937x.h
@@ -17,4 +17,8 @@ void lan937x_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val);
 int lan937x_change_mtu(struct ksz_device *dev, int port, int new_mtu);
 void lan937x_phylink_get_caps(struct ksz_device *dev, int port,
 			      struct phylink_config *config);
+void lan937x_phylink_mac_link_up(struct ksz_device *dev, int port,
+				 unsigned int mode, phy_interface_t interface,
+				 struct phy_device *phydev, int speed,
+				 int duplex, bool tx_pause, bool rx_pause);
 #endif
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 8cb46caf5340..95700e0233de 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -312,6 +312,60 @@ int lan937x_change_mtu(struct ksz_device *dev, int port, int new_mtu)
 	return 0;
 }
 
+static void lan937x_config_gbit(struct ksz_device *dev, bool gbit, u8 *data)
+{
+	if (gbit)
+		*data &= ~PORT_MII_NOT_1GBIT;
+	else
+		*data |= PORT_MII_NOT_1GBIT;
+}
+
+static void lan937x_config_interface(struct ksz_device *dev, int port,
+				     int speed, int duplex,
+				     bool tx_pause, bool rx_pause)
+{
+	u8 xmii_ctrl0, xmii_ctrl1;
+
+	ksz_pread8(dev, port, REG_PORT_XMII_CTRL_0, &xmii_ctrl0);
+	ksz_pread8(dev, port, REG_PORT_XMII_CTRL_1, &xmii_ctrl1);
+
+	switch (speed) {
+	case SPEED_1000:
+		lan937x_config_gbit(dev, true, &xmii_ctrl1);
+		break;
+	case SPEED_100:
+		lan937x_config_gbit(dev, false, &xmii_ctrl1);
+		xmii_ctrl0 |= PORT_MII_100MBIT;
+		break;
+	case SPEED_10:
+		lan937x_config_gbit(dev, false, &xmii_ctrl1);
+		xmii_ctrl0 &= ~PORT_MII_100MBIT;
+		break;
+	default:
+		dev_err(dev->dev, "Unsupported speed on port %d: %d\n",
+			port, speed);
+		return;
+	}
+
+	if (duplex)
+		xmii_ctrl0 |= PORT_MII_FULL_DUPLEX;
+	else
+		xmii_ctrl0 &= ~PORT_MII_FULL_DUPLEX;
+
+	if (tx_pause)
+		xmii_ctrl0 |= PORT_MII_TX_FLOW_CTRL;
+	else
+		xmii_ctrl1 &= ~PORT_MII_TX_FLOW_CTRL;
+
+	if (rx_pause)
+		xmii_ctrl0 |= PORT_MII_RX_FLOW_CTRL;
+	else
+		xmii_ctrl0 &= ~PORT_MII_RX_FLOW_CTRL;
+
+	ksz_pwrite8(dev, port, REG_PORT_XMII_CTRL_0, xmii_ctrl0);
+	ksz_pwrite8(dev, port, REG_PORT_XMII_CTRL_1, xmii_ctrl1);
+}
+
 void lan937x_phylink_get_caps(struct ksz_device *dev, int port,
 			      struct phylink_config *config)
 {
@@ -324,6 +378,19 @@ void lan937x_phylink_get_caps(struct ksz_device *dev, int port,
 	}
 }
 
+void lan937x_phylink_mac_link_up(struct ksz_device *dev, int port,
+				 unsigned int mode, phy_interface_t interface,
+				 struct phy_device *phydev, int speed,
+				 int duplex, bool tx_pause, bool rx_pause)
+{
+	/* Internal PHYs */
+	if (dev->info->internal_phy[port])
+		return;
+
+	lan937x_config_interface(dev, port, speed, duplex,
+				 tx_pause, rx_pause);
+}
+
 int lan937x_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index 19f3aa344228..c187d0a3e7fa 100644
--- a/drivers/net/dsa/microchip/lan937x_reg.h
+++ b/drivers/net/dsa/microchip/lan937x_reg.h
@@ -139,6 +139,17 @@
 #define PORT_MII_RX_FLOW_CTRL		BIT(3)
 #define PORT_GRXC_ENABLE		BIT(0)
 
+#define REG_PORT_XMII_CTRL_1		0x0301
+#define PORT_MII_NOT_1GBIT		BIT(6)
+#define PORT_MII_SEL_EDGE		BIT(5)
+#define PORT_RGMII_ID_IG_ENABLE		BIT(4)
+#define PORT_RGMII_ID_EG_ENABLE		BIT(3)
+#define PORT_MII_MAC_MODE		BIT(2)
+#define PORT_MII_SEL_M			0x3
+#define PORT_RGMII_SEL			0x0
+#define PORT_RMII_SEL			0x1
+#define PORT_MII_SEL			0x2
+
 /* 4 - MAC */
 #define REG_PORT_MAC_CTRL_0		0x0400
 #define PORT_CHECK_LENGTH		BIT(2)
-- 
2.36.1

