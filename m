Return-Path: <bpf+bounces-20581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499B840629
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1DE1F24F69
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8576519C;
	Mon, 29 Jan 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SF4+9r9R"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845E0627F4;
	Mon, 29 Jan 2024 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533553; cv=none; b=NLUTxdRmRvtXo6TurBDgNIbPvL9XerNHs0V48IV9b8pJLeXMz/eg/QQl0SHcfBkxHc3PqTw0USF+M0lZlI7lhW6L3Zo8MDKRkSePvED2bMNBwfDL5dWkdtw/4dnJJU9TSHFAmBKDMlgo+yRDM+vPoG7BIBFs40AiE8NhUlPR+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533553; c=relaxed/simple;
	bh=swhxBtRu+RCpSe8dZMPl6Dv+QRyu2q9F2b9dNeHS8cM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3f3d7Gn2GIUmeQJxQWojfFYSweQTspJZNw8Horab0f9EL/Mfc4WxBYYU5kCceX8cNHkOPjBILYo4Mwf0o4diJudn2SfXj4H+BoNntSbF0m4DpttQDEn2zJFDH/G6hWQm3JDCFaMQ7RZZnoQ3Cze04n4+N6dyd9yf5ZiNnhBXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SF4+9r9R; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706533552; x=1738069552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=swhxBtRu+RCpSe8dZMPl6Dv+QRyu2q9F2b9dNeHS8cM=;
  b=SF4+9r9RT1IReowuWanzD0Ll+i904ZhLhBZ/WGPemvvmVzl0nYb3vhSe
   EEdaSWE+1xbsl4uZUMQQV1jxq/Rcvw1c3N2RCsM79mwA0RGaDpscDXUAz
   tvsEgaNHWAYTa5CNu7Lp39L/ffdG5YxoWNSUcTfM2ew4zKPEryRosv3ID
   LwcxGzceuYGKXefvLJSNNSuCXgrITmF0719qPMH8RqUjZO/cD9Of905wQ
   dG4UaFzIoyazfUDcfLBx98uEN3+vi+kMa0ggM1l8sHZamaemANKq27nUo
   gR69Yk3R+jCbZRX648nIucsLwV6WnT+h68KiVmF5/YQCIkc172fy4MuTy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21473469"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21473469"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="907106807"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="907106807"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.229.33])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2024 05:05:43 -0800
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
Subject: [PATCH net-next v4 05/11] net: stmmac: select PCS negotiation mode according to the interface mode
Date: Mon, 29 Jan 2024 21:02:47 +0800
Message-Id: <20240129130253.1400707-6-yong.liang.choong@linux.intel.com>
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

The 'stmmac_get_pcs_neg_mode' is invoked during link initialization or
interface mode changes.

In cases where 'priv->plat->get_pcs_neg_mode' is absent, the default
'phylink_pcs_neg_mode' function is utilized.

Additionally, the 'intel_get_pcs_neg_mode' function is available to
determine the PCS negotiation mode based on the provided interface mode.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 44 +++++++++++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 17 +++++++
 include/linux/stmmac.h                        |  2 +
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 60283543ffc8..5110af776c8f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -414,6 +414,39 @@ static void intel_mgbe_pse_crossts_adj(struct intel_priv_data *intel_priv,
 	}
 }
 
+static bool is_fixed_link(struct pci_dev *pdev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
+	bool is_fixed_link = false;
+
+	if (fwnode) {
+		struct fwnode_handle *fixed_node;
+
+		fixed_node = fwnode_get_named_child_node(fwnode, "fixed-link");
+		if (fixed_node)
+			is_fixed_link = true;
+
+		fwnode_handle_put(fixed_node);
+	}
+
+	return is_fixed_link;
+}
+
+static unsigned int intel_get_pcs_neg_mode(phy_interface_t interface,
+					   struct pci_dev *pdev)
+{
+	unsigned int neg_mode;
+
+	if ((interface == PHY_INTERFACE_MODE_SGMII ||
+	     interface == PHY_INTERFACE_MODE_1000BASEX) &&
+	     !is_fixed_link(pdev))
+		neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+	else
+		neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+
+	return neg_mode;
+}
+
 static void common_default_data(struct plat_stmmacenet_data *plat)
 {
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
@@ -590,15 +623,8 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	}
 
 	/* For fixed-link setup, we clear xpcs_an_inband */
-	if (fwnode) {
-		struct fwnode_handle *fixed_node;
-
-		fixed_node = fwnode_get_named_child_node(fwnode, "fixed-link");
-		if (fixed_node)
-			plat->mdio_bus_data->xpcs_an_inband = false;
-
-		fwnode_handle_put(fixed_node);
-	}
+	if (is_fixed_link(pdev))
+		plat->mdio_bus_data->xpcs_an_inband = false;
 
 	/* Ensure mdio bus scan skips intel serdes and pcs-xpcs */
 	plat->mdio_bus_data->phy_mask = 1 << INTEL_MGBE_ADHOC_ADDR;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d1ec075ae10a..00af5a4195fd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1104,11 +1104,28 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		stmmac_hwtstamp_correct_latency(priv, priv);
 }
 
+static unsigned int stmmac_get_pcs_neg_mode(struct phylink_config *config,
+					    unsigned int mode,
+					    phy_interface_t interface,
+					    const unsigned long *advertising)
+{
+	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+	unsigned int neg_mode;
+
+	if (priv->plat->get_pcs_neg_mode)
+		neg_mode = priv->plat->get_pcs_neg_mode(interface, priv->plat->pdev);
+	else
+		neg_mode = phylink_pcs_neg_mode(mode, interface, advertising);
+
+	return neg_mode;
+}
+
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
 	.mac_select_pcs = stmmac_mac_select_pcs,
 	.mac_config = stmmac_mac_config,
 	.mac_link_down = stmmac_mac_link_down,
 	.mac_link_up = stmmac_mac_link_up,
+	.mac_get_pcs_neg_mode = stmmac_get_pcs_neg_mode,
 };
 
 /**
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index b99d11f4ff26..778bdfc3f010 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -277,6 +277,8 @@ struct plat_stmmacenet_data {
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
 	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
+	unsigned int (*get_pcs_neg_mode)(phy_interface_t interface,
+					 struct pci_dev *pdev);
 	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
-- 
2.34.1


