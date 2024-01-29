Return-Path: <bpf+bounces-20582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F399984062E
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F411F251CD
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCDF657AF;
	Mon, 29 Jan 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkgP2yj3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6A657A1;
	Mon, 29 Jan 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533561; cv=none; b=uhARc6BWv9z7d8g6PxtLdzUbJaNianUq77MSox9eDqUbbLI9lVh2AXkDn9QxHjIpt+nF1XYUYW5msqMdoqJ03OcioUahiF0b55pAO/eFXnpbwX1zPVok6IXicYt/h2LLzR2koa3jh4r4urXW90iaGaaW/NGJqHpsBHONCww4ZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533561; c=relaxed/simple;
	bh=ILh5Z5Vi57AO1xeYu8g/LMT4tyMxPDgYH1LL/1ZQ0hA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=laVLJnqfrPgn6nlmVq+CdI3aRd2Nz5Vdkcp6lwGznXEms3SLNvfT0COK1Gyr+mMqqiHLce/ucINfFP/kAZYBMLGahn9ReHx8O/WA9luJbI3/HTcR47FIu4PxYdYKeP01WZAxtioPC6ZzKIQ03a5i4t6P1ZYgsUpgPprpd5DlXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkgP2yj3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706533561; x=1738069561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ILh5Z5Vi57AO1xeYu8g/LMT4tyMxPDgYH1LL/1ZQ0hA=;
  b=hkgP2yj33KbU+cBx1PUiA9R5oRrCgYYorRm6Su3tlCMn/U7la2yKFlU2
   455QT7cUpJYF0JzDwl9gi1KS4FA7KFAv9vHD0JffO/1LQk6i7gDS5PDwq
   MbXS47u0J7s8HcAA8yuVhxbSbj5mUCdhhLOCbPyC7923dFwUzWKPS0fSe
   2DhiVAGQXnSX5j2F+j0DJD7yEh1mI7dopp+kHN+JK804m93TGxYtAxGIQ
   3Y0KtJ+0ayBaswNrQ8hIO8hdwgcnoWMp503Vw3lvKU45hy0DiBxuNgIcy
   Zp/YqvWfPr/ZMvU33Th19Q0vsqZIg2rQxU2/F5XC5U0MqmP5kLu0EFDAv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21473502"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21473502"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="907106826"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907106826"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2024 05:05:52 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org,
	Voon Wei Feng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>,
	Abdul Rahim Faizal <faizal.abdul.rahim@intel.com>
Subject: [PATCH net-next v4 06/11] net: stmmac: resetup XPCS according to the new interface mode
Date: Mon, 29 Jan 2024 21:02:48 +0800
Message-Id: <20240129130253.1400707-7-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
References: <20240129130253.1400707-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XPCS creation will map the configuration for the provided interface mode.
Then XPCS will operate according to the interface mode.

When the interface mode changes, XPCS is required to map the configuration
to the new interface mode and destroy the old interface mode where it
is not in use.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  7 +++----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index f155e4841c62..886efd26991e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -357,7 +357,7 @@ enum stmmac_state {
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
-int stmmac_xpcs_setup(struct mii_bus *mii);
+int stmmac_xpcs_setup(struct mii_bus *mii, phy_interface_t interface);
 void stmmac_set_ethtool_ops(struct net_device *netdev);
 
 int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 00af5a4195fd..50429c985441 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -941,8 +941,17 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
-	if (priv->hw->xpcs)
+	if (priv->hw->xpcs) {
+		if (interface != PHY_INTERFACE_MODE_NA &&
+		    interface != priv->plat->phy_interface) {
+			/* When there are major changes, we reconfigure
+			 * the setup for xpcs according to the interface.
+			 */
+			xpcs_destroy(priv->hw->xpcs);
+			stmmac_xpcs_setup(priv->mii, interface);
+		}
 		return &priv->hw->xpcs->pcs;
+	}
 
 	if (priv->hw->lynx_pcs)
 		return priv->hw->lynx_pcs;
@@ -7737,7 +7746,7 @@ int stmmac_dvr_probe(struct device *device,
 		priv->plat->speed_mode_2500(ndev, priv->plat->bsp_priv);
 
 	if (priv->plat->mdio_bus_data && priv->plat->mdio_bus_data->has_xpcs) {
-		ret = stmmac_xpcs_setup(priv->mii);
+		ret = stmmac_xpcs_setup(priv->mii, priv->plat->phy_interface);
 		if (ret)
 			goto error_xpcs_setup;
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 0542cfd1817e..1be144f3dee9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -495,19 +495,18 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 	return 0;
 }
 
-int stmmac_xpcs_setup(struct mii_bus *bus)
+int stmmac_xpcs_setup(struct mii_bus *bus, phy_interface_t interface)
 {
 	struct net_device *ndev = bus->priv;
 	struct stmmac_priv *priv;
 	struct dw_xpcs *xpcs;
-	int mode, addr;
+	int addr;
 
 	priv = netdev_priv(ndev);
-	mode = priv->plat->phy_interface;
 
 	/* Try to probe the XPCS by scanning all addresses. */
 	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-		xpcs = xpcs_create_mdiodev(bus, addr, mode);
+		xpcs = xpcs_create_mdiodev(bus, addr, interface);
 		if (IS_ERR(xpcs))
 			continue;
 
-- 
2.34.1


