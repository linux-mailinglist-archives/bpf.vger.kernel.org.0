Return-Path: <bpf+bounces-10541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D19197A98F6
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 20:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA62B21454
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A643A84;
	Thu, 21 Sep 2023 17:22:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8593F4C1;
	Thu, 21 Sep 2023 17:22:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BE751F7B;
	Thu, 21 Sep 2023 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316628; x=1726852628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lTXXgtikZK8fOV2paXgb9h3Lt1o9zA5yS/eHowFJJOE=;
  b=KRDmTtOpSMmjsqzHqliaUmm1/gPNKHP9zItXGpAmm3GSIo190LktVyMS
   MFX+oi4UUxD/tcunceT50U5RjLrV8tAaSv1Z6P8VkiYRtIu731xR3Az8T
   rUx5ozMX+yj8aehngSm4fuE4u7vbINM+5ZnmxjuLXltnU+QcbWaFtoGXF
   uUtzUMlNM4C92ZoO1BbqKl2DCzmU2tke41q3asfKGXF/7d+49Yob3kYRb
   7l+NH4DQowtbGOLKStDdHoPcl68w8b3voNcgpcTKzQqE7zTQWJxib5GXW
   W24uGTchsFLgpv7Ys2OQstkOaW83HA4cDQqHjOoX4t5m6l/duXBlavBiP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444608265"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="444608265"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 05:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="862441935"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="862441935"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2023 05:20:48 -0700
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
Cc: David E Box <david.e.box@intel.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	netdev@vger.kernel.org,
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
Subject: [PATCH net-next v3 3/5] net: phy: update in-band AN mode when changing interface by PHY driver
Date: Thu, 21 Sep 2023 20:19:44 +0800
Message-Id: <20230921121946.3025771-4-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
References: <20230921121946.3025771-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As there is a mechanism in PHY drivers to switch the PHY interface
between SGMII and 2500BaseX according to link speed. In this case,
the in-band AN mode should be switching based on the PHY interface
as well, if the PHY interface has been changed/updated by PHY driver.

For e.g., disable in-band AN in 2500BaseX mode, or enable in-band AN
back for SGMII mode (10/100/1000Mbps).

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/phy/phylink.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0d7354955d62..5811c8086149 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1723,6 +1723,34 @@ bool phylink_expects_phy(struct phylink *pl)
 }
 EXPORT_SYMBOL_GPL(phylink_expects_phy);
 
+/**
+ * phylink_interface_change() - update both cfg_link_an_mode and
+ * cur_link_an_mode when there is a change in the interface.
+ * @phydev: pointer to &struct phy_device
+ *
+ * When the PHY interface switches between SGMII and 2500BaseX in
+ * accordance with the link speed, the in-band AN mode should also switch
+ * based on the PHY interface
+ */
+static void phylink_interface_change(struct phy_device *phydev)
+{
+	struct phylink *pl = phydev->phylink;
+
+	if (pl->phy_state.interface != phydev->interface) {
+		/* Fallback to the correct AN mode. */
+		if (phy_interface_mode_is_8023z(phydev->interface) &&
+		    pl->cfg_link_an_mode == MLO_AN_INBAND) {
+			pl->cfg_link_an_mode = MLO_AN_PHY;
+			pl->cur_link_an_mode = MLO_AN_PHY;
+		} else if (pl->config->ovr_an_inband) {
+			pl->cfg_link_an_mode = MLO_AN_INBAND;
+			pl->cur_link_an_mode = MLO_AN_INBAND;
+		}
+
+		pl->phy_state.interface = phydev->interface;
+	}
+}
+
 static void phylink_phy_change(struct phy_device *phydev, bool up)
 {
 	struct phylink *pl = phydev->phylink;
@@ -1739,7 +1767,7 @@ static void phylink_phy_change(struct phy_device *phydev, bool up)
 		pl->phy_state.pause |= MLO_PAUSE_TX;
 	if (rx_pause)
 		pl->phy_state.pause |= MLO_PAUSE_RX;
-	pl->phy_state.interface = phydev->interface;
+	phylink_interface_change(phydev);
 	pl->phy_state.link = up;
 	mutex_unlock(&pl->state_mutex);
 
-- 
2.25.1


