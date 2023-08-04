Return-Path: <bpf+bounces-6971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE8276FC68
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6351C21637
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C279475;
	Fri,  4 Aug 2023 08:47:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D1FA934;
	Fri,  4 Aug 2023 08:47:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178EE4EE4;
	Fri,  4 Aug 2023 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691138851; x=1722674851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kym71JnP46JQRzivmbFD91p1WZYXtds413slM9QU9Oo=;
  b=b8UZPIsxwYqeGwlqiDK9RNUdzoSAMGDtutBEEZOFxL2DViEi05xC9t3u
   CKzG2vsRCdmsQ7tWAep8r4UoQsN/CeVKRqFUztl00FUEHnc2XqofMyDWh
   B3qRYIA/T/mrn2a2Vj7bAQAkM8RjAHqiOUNqzDVo+wJNsditbuQgaHRUu
   vaIsNWlgNVAVtS9Nr9wuzXjH39EEd4z/qUKrHvPd7GSlKluSbBDKWsJfq
   1M8SbAOc880q+pAF5kzkntZROCGV1wDSuvnGob/0y67J7pC3DTXkwcwMs
   Y9PsC4mUcxNHLduh740HvuTFH01zmJheBEnf8qconsyWIqls1tc0eEYeM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456478557"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="456478557"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 01:47:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="765018164"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="765018164"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2023 01:47:19 -0700
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
Subject: [PATCH net-next v2 3/5] net: phy: update in-band AN mode when changing interface by PHY driver
Date: Fri,  4 Aug 2023 16:45:25 +0800
Message-Id: <20230804084527.2082302-4-yong.liang.choong@linux.intel.com>
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

Add cur_link_an_mode into phy_device struct for PHY drivers to
communicate the in-band AN mode setting with phylink framework.

As there is a mechanism in PHY drivers to switch the PHY interface
between SGMII and 2500BaseX according to link speed. In this case,
the in-band AN mode should be switching based on the PHY interface
as well, if the PHY interface has been changed/updated by PHY driver.

For e.g., disable in-band AN in 2500BaseX mode, or enable in-band AN
back for SGMII mode (10/100/1000Mbps).

Signed-off-by: Tan, Tee Min <tee.min.tan@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/phy/marvell10g.c | 6 ++++++
 drivers/net/phy/phylink.c    | 4 ++++
 include/linux/phy.h          | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index d4bb90d76881..a9df19278618 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -30,6 +30,7 @@
 #include <linux/phy.h>
 #include <linux/sfp.h>
 #include <linux/netdevice.h>
+#include <linux/phylink.h>
 
 #define MV_PHY_ALASKA_NBT_QUIRK_MASK	0xfffffffe
 #define MV_PHY_ALASKA_NBT_QUIRK_REV	(MARVELL_PHY_ID_88X3310 | 0xa)
@@ -946,6 +947,9 @@ static void mv3310_update_interface(struct phy_device *phydev)
 	 * xaui / rxaui modes according to the speed.
 	 * Florian suggests setting phydev->interface to communicate this to the
 	 * MAC. Only do this if we are already in one of the above modes.
+	 * In-band Auto-negotiation is not supported in 2500BASE-X.
+	 * Setting phydev->cur_link_an_mode to communicate this to the
+	 * phylink framework.
 	 */
 	switch (phydev->speed) {
 	case SPEED_10000:
@@ -956,11 +960,13 @@ static void mv3310_update_interface(struct phy_device *phydev)
 		break;
 	case SPEED_2500:
 		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+		phydev->cur_link_an_mode = MLO_AN_PHY;
 		break;
 	case SPEED_1000:
 	case SPEED_100:
 	case SPEED_10:
 		phydev->interface = PHY_INTERFACE_MODE_SGMII;
+		phydev->cur_link_an_mode = MLO_AN_INBAND;
 		break;
 	default:
 		break;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4f1c8bb199e9..f9cbb6d7e134 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1720,6 +1720,8 @@ static void phylink_phy_change(struct phy_device *phydev, bool up)
 		pl->phy_state.pause |= MLO_PAUSE_RX;
 	pl->phy_state.interface = phydev->interface;
 	pl->phy_state.link = up;
+	pl->cur_link_an_mode = phydev->cur_link_an_mode;
+	pl->cfg_link_an_mode = phydev->cur_link_an_mode;
 	mutex_unlock(&pl->state_mutex);
 
 	phylink_run_resolve(pl);
@@ -1824,6 +1826,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	if (pl->config->mac_managed_pm)
 		phy->mac_managed_pm = true;
 
+	pl->phydev->cur_link_an_mode = pl->cur_link_an_mode;
+
 	return 0;
 }
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index ba08b0e60279..4973f2852a79 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -619,6 +619,7 @@ struct macsec_ops;
  * @link_down_events: Number of times link was lost
  * @shared: Pointer to private data shared by phys in one package
  * @priv: Pointer to driver private data
+ * @cur_link_an_mode: Current AN mode setting with phylink framework
  *
  * interrupts currently only supports enabled or disabled,
  * but could be changed in the future to support enabling
@@ -757,6 +758,8 @@ struct phy_device {
 	/* MACsec management functions */
 	const struct macsec_ops *macsec_ops;
 #endif
+	/* For communicate the AN mode setting with phylink framework. */
+	u8 cur_link_an_mode;
 };
 
 /* Generic phy_device::dev_flags */
-- 
2.25.1


