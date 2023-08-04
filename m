Return-Path: <bpf+bounces-6970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A947276FC61
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69931C217CD
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAB2A929;
	Fri,  4 Aug 2023 08:47:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6688825;
	Fri,  4 Aug 2023 08:47:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6176749E8;
	Fri,  4 Aug 2023 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691138839; x=1722674839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kWetqXl79fvZjr8fdZOpXU/jjIveLKoNgaP1hXW6Rng=;
  b=HMrQXo+f15DXDASgEiTq8cm9Xboeg75ag2C1eSZaAjx9yDc4NfINlWD3
   4kYhaubwP9Xh3tLUpVCDLX3jp4VXLdW1vVzsWzW6mU5YEO7js3enHPtlU
   9ThhpEEXRvV8LVLTjwaJ1LlyFAmD7BosDWNGxizFfDWleIbsL+jyB2+K/
   INey8Sf1IdjCe5O4bwQNUjMC4jGXpkHKwfrfXR9VlMp+9F68RLMHM46/W
   MLu3xw9qCqnH3Q3bixw2Yn1TM1fNGfotsRVURm9g0BE+Ha0WP40q8em6Y
   74mMX0iqbnhB4sfBl0dDAvp+bXGdg8WYN/23UKYnxOgSO9MbzZyjOXWlz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456478430"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="456478430"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="765018035"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="765018035"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2023 01:47:08 -0700
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Wong Vee Khee <veekhee@apple.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Revanth Kumar Uppala <ruppala@nvidia.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrey Konovalov <andrey.konovalov@linaro.org>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org,
	Voon Wei Feng <weifeng.voon@intel.com>,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: [PATCH net-next v2 2/5] net: pcs: xpcs: combine C37 SGMII AN and 2500BASEX for Intel mGbE controller
Date: Fri,  4 Aug 2023 16:45:24 +0800
Message-Id: <20230804084527.2082302-3-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
References: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "Tan, Tee Min" <tee.min.tan@linux.intel.com>

This commit introduces xpcs_sgmii_2500basex_features[] that combine
xpcs_sgmii_features[] and xpcs_2500basex_features[] for Intel mGbE
controller that desire to interchange the speed mode of
10/100/1000/2500Mbps at runtime.

Also, we introduce xpcs_config_aneg_c37_sgmii_2500basex() function
which is called by the xpcs_do_config() with the new AN mode:
DW_SGMII_2500BASEX, and this new function will proceed next-level
calling to perform C37 SGMII AN/2500BASEX configuration based on
the PHY interface updated by PHY driver.

Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/pcs/pcs-xpcs.c   | 72 ++++++++++++++++++++++++++++++------
 include/linux/pcs/pcs-xpcs.h |  1 +
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 44b037646865..b35767f65d62 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -104,6 +104,21 @@ static const int xpcs_2500basex_features[] = {
 	__ETHTOOL_LINK_MODE_MASK_NBITS,
 };
 
+static const int xpcs_sgmii_2500basex_features[] = {
+	ETHTOOL_LINK_MODE_Pause_BIT,
+	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+	ETHTOOL_LINK_MODE_Autoneg_BIT,
+	ETHTOOL_LINK_MODE_10baseT_Half_BIT,
+	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_2500baseX_Full_BIT,
+	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+	__ETHTOOL_LINK_MODE_MASK_NBITS,
+};
+
 static const phy_interface_t xpcs_usxgmii_interfaces[] = {
 	PHY_INTERFACE_MODE_USXGMII,
 };
@@ -133,6 +148,12 @@ static const phy_interface_t xpcs_2500basex_interfaces[] = {
 	PHY_INTERFACE_MODE_MAX,
 };
 
+static const phy_interface_t xpcs_sgmii_2500basex_interfaces[] = {
+	PHY_INTERFACE_MODE_SGMII,
+	PHY_INTERFACE_MODE_2500BASEX,
+	PHY_INTERFACE_MODE_MAX,
+};
+
 enum {
 	DW_XPCS_USXGMII,
 	DW_XPCS_10GKR,
@@ -141,6 +162,7 @@ enum {
 	DW_XPCS_SGMII,
 	DW_XPCS_1000BASEX,
 	DW_XPCS_2500BASEX,
+	DW_XPCS_SGMII_2500BASEX,
 	DW_XPCS_INTERFACE_MAX,
 };
 
@@ -267,6 +289,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
 	case DW_AN_C37_SGMII:
 	case DW_2500BASEX:
 	case DW_AN_C37_1000BASEX:
+	case DW_SGMII_2500BASEX:
 		dev = MDIO_MMD_VEND2;
 		break;
 	default:
@@ -713,6 +736,8 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	else
 		ret &= ~DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 
+	/* Disable 2.5G GMII for SGMII C37 mode */
+	ret &= ~DW_VR_MII_DIG_CTRL1_2G5_EN;
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL1, ret);
 	if (ret < 0)
 		return ret;
@@ -808,6 +833,26 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
 	return xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_CTRL, ret);
 }
 
+static int xpcs_config_aneg_c37_sgmii_2500basex(struct dw_xpcs *xpcs,
+						unsigned int neg_mode,
+						phy_interface_t interface)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		ret = xpcs_config_aneg_c37_sgmii(xpcs, neg_mode);
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		ret = xpcs_config_2500basex(xpcs);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 		   const unsigned long *advertising, unsigned int neg_mode)
 {
@@ -844,6 +889,12 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 		if (ret)
 			return ret;
 		break;
+	case DW_SGMII_2500BASEX:
+		ret = xpcs_config_aneg_c37_sgmii_2500basex(xpcs, neg_mode,
+							   interface);
+		if (ret)
+			return ret;
+		break;
 	default:
 		return -1;
 	}
@@ -1030,6 +1081,11 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
 		}
 		break;
 	case DW_AN_C37_SGMII:
+	case DW_SGMII_2500BASEX:
+		/* 2500BASEX is not supported for in-band AN mode. */
+		if (state->interface == PHY_INTERFACE_MODE_2500BASEX)
+			break;
+
 		ret = xpcs_get_state_c37_sgmii(xpcs, state);
 		if (ret) {
 			pr_err("xpcs_get_state_c37_sgmii returned %pe\n",
@@ -1182,23 +1238,17 @@ static const struct xpcs_compat synopsys_xpcs_compat[DW_XPCS_INTERFACE_MAX] = {
 		.num_interfaces = ARRAY_SIZE(xpcs_10gbaser_interfaces),
 		.an_mode = DW_10GBASER,
 	},
-	[DW_XPCS_SGMII] = {
-		.supported = xpcs_sgmii_features,
-		.interface = xpcs_sgmii_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_sgmii_interfaces),
-		.an_mode = DW_AN_C37_SGMII,
-	},
 	[DW_XPCS_1000BASEX] = {
 		.supported = xpcs_1000basex_features,
 		.interface = xpcs_1000basex_interfaces,
 		.num_interfaces = ARRAY_SIZE(xpcs_1000basex_interfaces),
 		.an_mode = DW_AN_C37_1000BASEX,
 	},
-	[DW_XPCS_2500BASEX] = {
-		.supported = xpcs_2500basex_features,
-		.interface = xpcs_2500basex_interfaces,
-		.num_interfaces = ARRAY_SIZE(xpcs_2500basex_interfaces),
-		.an_mode = DW_2500BASEX,
+	[DW_XPCS_SGMII_2500BASEX] = {
+		.supported = xpcs_sgmii_2500basex_features,
+		.interface = xpcs_sgmii_2500basex_interfaces,
+		.num_interfaces = ARRAY_SIZE(xpcs_sgmii_2500basex_features),
+		.an_mode = DW_SGMII_2500BASEX,
 	},
 };
 
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index ff99cf7a5d0d..a1625e1c5875 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -19,6 +19,7 @@
 #define DW_2500BASEX			3
 #define DW_AN_C37_1000BASEX		4
 #define DW_10GBASER			5
+#define DW_SGMII_2500BASEX		6
 
 struct xpcs_id;
 
-- 
2.25.1


